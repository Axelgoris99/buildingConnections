# dialog.gd
extends State

var character : Character
var dialog_manager
var hover_character

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	if !_msg.has("character"):
		state_machine.transition_to("idle")
	if _msg.has("hover_menu"):
		hover_character = _msg.hover_menu
	character = _msg.character
	var managers = get_tree().get_nodes_in_group("managers")
	for node in managers:
		if(node.name == "DialogManager"):
			dialog_manager = node
			break
	Dialogic.timeline_ended.connect(on_dialog_end)
	dialog_manager.run_dialog(character, character.likes, character.dislikes)

func on_dialog_end():
	character.add_known_objects(character.likes + character.dislikes)
	if hover_character:
		hover_character.queue_free()
	state_machine.transition_to("idle")
