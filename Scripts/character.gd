extends Node

var current_chair
var likes = []
var dislikes = []
@export var display_name: String = "test"
func set_chair(chair):
	current_chair = chair
	current_chair.set_character(self)

func remove_chair():
	if(!current_chair):
		return
	current_chair.set_character(null)
	current_chair = null
