# initialization.gd
extends State

var current_character: Node3D
var hover_menu: Node

var chairs
var current_chair: Node3D

var highlightMaterial: ShaderMaterial
var hoverMaterial: ShaderMaterial 


# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	if !_msg.has("character"):
		state_machine.transition_to("idle")
		return
	if _msg.has("hover_menu"):
		hover_menu = _msg.hover_menu
	current_character = _msg.character
	highlightMaterial = load("res://Materials/outlineHover.tres")
	hoverMaterial = load("res://Materials/outlineSelect.tres")
	var material = current_character.get_node("StaticBody/Mesh") as MeshInstance3D
	material.material_overlay = hoverMaterial
	chairs = get_tree().get_nodes_in_group("chairs")
	connect_chairs()
	highlight_chairs()

func exit():
	hover_menu.queue_free()
	disconnect_chairs()
	unhighlight_chairs()
	var material = current_character.get_node("StaticBody/Mesh") as MeshInstance3D
	material.material_overlay = null
	current_chair = null
	current_character = null

func handle_input(event):
	if(Input.is_action_just_released("interact")):
		state_machine.transition_to("idle")
	if(!current_chair):
		return
	if(Input.is_action_just_released("select")):
		place_character()

func place_character():
	current_character.remove_chair()
	current_character.global_position = current_chair.global_position
	current_character.set_chair(current_chair)
	state_machine.transition_to("idle")

func connect_chairs():
	for chair in chairs:
		if(chair.current_character):
			continue
		var body = chair.get_node("StaticBody")
		body.mouse_entered.connect(on_chair_hovered.bind(chair))
		body.mouse_exited.connect(on_chair_unhovered.bind(chair))
	
func disconnect_chairs():
	for chair in chairs:
		var body = chair.get_node("StaticBody")
		if(body.mouse_entered.is_connected(on_chair_hovered)):
			body.mouse_entered.disconnect(on_chair_hovered)
		if(body.mouse_exited.is_connected(on_chair_unhovered)):
			body.mouse_exited.disconnect(on_chair_unhovered)
	
func on_chair_hovered(chair):
	current_chair = chair
	chair.get_node("StaticBody/Mesh").material_overlay = hoverMaterial

func on_chair_unhovered(chair):
	current_chair = null
	chair.get_node("StaticBody/Mesh").material_overlay = highlightMaterial

func highlight_chair(chair):
	chair.get_node("StaticBody/Mesh").material_overlay = highlightMaterial

func highlight_chairs():
	for chair in chairs:
		highlight_chair(chair)

func unhighlight_chair(chair):
		chair.get_node("StaticBody/Mesh").material_overlay = null

func unhighlight_chairs():
	for chair in chairs:
		unhighlight_chair(chair)
