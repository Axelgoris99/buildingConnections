# idle.gd
extends State

var _character: Node3D
var characters

var hover_template: PackedScene
var hover_menu: Node

var end_button: Node

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	if !end_button:
		end_button = preload("res://Scenes/UI/end_button.tscn").instantiate()
		add_child(end_button)
	end_button.show()
	end_button.get_node("Button").pressed.connect(transition_to_end)
	hover_template = preload("res://Scenes/UI/hover_character.tscn") as PackedScene
	hover_menu = null
	characters = get_tree().get_nodes_in_group("characters")
	_character = null
	connect_characters_colliders()
	
func exit():
	end_button.hide()
	end_button.get_node("Button").pressed.disconnect(transition_to_end)
	disconnect_characters_colliders()
	_character = null

func transition_to_end():
	Music.play_success()
	state_machine.transition_to("score")
	
func on_character_hovered(character: Node3D):
	_character = character
	var material = character.get_node("StaticBody/AnimatedChar/Armature/Skeleton3D/Mesh") as MeshInstance3D
	hover_menu = hover_template.instantiate()
	hover_menu.set_character(character)	
	add_child(hover_menu)
	material.material_overlay = load("res://Materials/outlineHover.tres")
	
func on_character_unhovered(character: Node3D):
	_character = null
	var material = character.get_node("StaticBody/AnimatedChar/Armature/Skeleton3D/Mesh") as MeshInstance3D
	if(hover_menu):
		hover_menu.queue_free()
	material.material_overlay = null

func handle_input(event):
	if(!_character):
		return
	if(Input.is_action_just_released("select")):
		Music.play_picking()
		state_machine.transition_to("placement", {character = _character, hover_menu = hover_menu })
	if(Input.is_action_just_released("interact")):
		Music.play_picking()
		state_machine.transition_to("dialog", {character = _character, hover_menu = hover_menu })

func connect_characters_colliders():
	for character in characters:
		var body = character.get_node("StaticBody")
		body.mouse_entered.connect(on_character_hovered.bind(character))
		body.mouse_exited.connect(on_character_unhovered.bind(character))

func disconnect_characters_colliders():
	for character in characters:
		var body = character.get_node("StaticBody")
		body.mouse_entered.disconnect(on_character_hovered)
		body.mouse_exited.disconnect(on_character_unhovered)
