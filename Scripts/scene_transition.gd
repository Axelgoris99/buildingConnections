extends CanvasLayer

func change_scene_to_file(target: String):
	$AnimationPlayer.play("slide")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("slide")

func reload_scene():
	$AnimationPlayer.play("slide")
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play_backwards("slide")
