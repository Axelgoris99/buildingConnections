extends Control


func _ready():
	Dialogic.start('tutorial')
	

func _on_button_pressed():
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('tutorial')
	
