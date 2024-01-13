# initialization.gd
extends State

var current_character: Node3D
var chairs
var current_chair: Node3D
# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	if !_msg.has("character"):
		return
	current_character = _msg.character
	chairs = get_tree().get_nodes_in_group("chairs")
	connect_chairs()
	highlight_chairs()

func exit():
	disconnect_chairs()
	current_chair = null
	current_character = null

func _input(event):
	if(Input.is_action_just_pressed("interact")):
		state_machine.transition_to("idle")
	if(!current_chair):
		return
	if(Input.is_action_just_pressed("select")):
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
	pass

func on_chair_unhovered(chair):
	current_chair = null
	pass

func highlight_chair():
	pass

func highlight_chairs():
	pass
		
