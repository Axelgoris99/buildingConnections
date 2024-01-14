class_name PauseMenu
extends Control

@export var pause_btn: Node
@export var pause_menu: Node

func _on_pause_btn_pressed():
	get_tree().paused = true
	pause_menu.show()
	pause_btn.hide()

func _on_resume_pressed():
	get_tree().paused = false
	pause_menu.hide()
	pause_btn.show()

func _on_main_menu_pressed():
	get_tree().paused = false
	SceneTransition.change_scene_to_file("res://Scenes/UI/menu.tscn")


