extends Control


func _on_lvl_1_pressed():
	Music.play_button()
	SceneTransition.change_scene_to_file("res://Scenes/lvls/lvl1.tscn")


func _on_lvl_2_pressed():
	pass # Replace with function body.


func _on_lvl_3_pressed():
	pass # Replace with function body.


func _on_lvl_4_pressed():
	pass # Replace with function body.


func _on_button_pressed():
	SceneTransition.change_scene_to_file("res://Scenes/UI/menu.tscn")
