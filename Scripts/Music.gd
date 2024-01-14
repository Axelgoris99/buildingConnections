extends AudioStreamPlayer

@export var button: AudioStreamPlayer
@export var placement: AudioStreamPlayer
@export var picking: AudioStreamPlayer
@export var success: AudioStreamPlayer

func play_button():
	button.play()

func play_placement():
	placement.play()

func play_picking():
	picking.play()

func play_success():
	success.play()
