extends Control

var current_character: Character

@export var name_label: RichTextLabel
@export var dislikes: VBoxContainer
@export var likes: VBoxContainer

func set_character(character: Character):
	current_character = character
	name_label.text = character.display_name.to_upper()
	# Not efficient but meh, no time
	for like in character.likes:
		if(like in character.known_objects):
			add_node(likes, like)
		else:
			add_unknown_node(likes)
	for dislike in character.dislikes:
		if(dislike in character.known_objects):
			add_node(dislikes, dislike)
		else:
			add_unknown_node(dislikes)

func add_unknown_node(parent_node: Node):
	var text_label = RichTextLabel.new()
	text_label.text = "?"
	text_label.fit_content = true
	parent_node.add_child(text_label)
	
func add_node(parent_node: Node, text: String):
	var text_label = RichTextLabel.new()
	text_label.text = text.to_upper()
	text_label.fit_content = true
	parent_node.add_child(text_label)
