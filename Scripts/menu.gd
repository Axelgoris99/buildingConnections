extends Control


func _on_start_button_pressed():
	Music.play_button()
	SceneTransition.change_scene_to_file("res://Scenes/UI/level_selection.tscn")

func _on_options_button_pressed():
	Music.play_button()
	SceneTransition.change_scene_to_file("res://Scenes/UI/options.tscn")
	
func _on_quit_button_pressed():
	Music.play_button()
	get_tree().quit()

