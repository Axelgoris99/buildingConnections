extends Control

func _on_button_pressed():
	Music.play_button()
	SceneTransition.change_scene_to_file("res://Scenes/UI/menu.tscn")
