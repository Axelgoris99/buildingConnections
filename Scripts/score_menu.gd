extends Control

@export var score_node: RichTextLabel
@export var highscore_node : RichTextLabel

func _on_retry_pressed():
	get_tree().paused = false
	SceneTransition.reload_scene()

func _on_main_menu_pressed():
	get_tree().paused = false
	SceneTransition.change_scene_to_file("res://Scenes/UI/menu.tscn")
