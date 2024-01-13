# idle.gd
extends State

var _character: Node3D
var characters
# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	characters = get_tree().get_nodes_in_group("characters")
	connect_characters_colliders()
	
func exit():
	disconnect_characters_colliders()
	_character = null

func on_character_hovered(character: Node3D):
	_character = character
	
func on_character_unhovered(character: Node3D):
	_character = null

func _input(event):
	if(!_character):
		return
	if(Input.is_action_just_pressed("select")):
		state_machine.transition_to("placement", {character = _character})
	if(Input.is_action_just_pressed("interact")):
		state_machine.transition_to("dialog", {character = _character})

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
