# initialization.gd
extends State

func enter(_msg := {}) -> void:
	score_csv()
	handle_taste_characters()
	handle_dialog_manager()
	state_machine.transition_to("idle")

func score_csv():
	var node = CsvScore.new()
	node.set_name("CsvScore")
	node.add_to_group("csv")
	add_child(node)

func handle_taste_characters():
	var node = CharacterManager.new()
	node.set_name("CharacterManager")
	add_child(node)
	node.add_to_group("managers")
	var characters = get_tree().get_nodes_in_group("characters")
	for character in characters:
		node.init_character(character, character.name)

func handle_dialog_manager():
	var node = DialogManager.new()
	node.set_name("DialogManager")
	node.add_to_group("managers")
	add_child(node)
	
