class_name CharacterManager
extends Node

# Initialise the given character likes, dislikes, and dialogue texts associated by reading the JSON file
func init_character(character : Character, character_name : String):
	var dialog_events = {}
	var json = JSON.new()
	var dialog_file = FileAccess.open("res://dialogs/" + character_name + ".json", FileAccess.READ) # Fixme better path access?
	var json_string = dialog_file.get_as_text()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			# At this point all dialog events of the character are stored in the distionary data_received
			# Now we need to split them into intro, likes and dislikes
			# Register intro events
			var intro_dialog_events : Array = []
			var likes_dialog_events : Dictionary = {}
			var likes: Array = []
			var dislikes_dialog_events : Dictionary = {}			
			var dislikes: Array = []
			for intro_event in data_received["intro"]:
				intro_dialog_events.append(intro_event["value"])
			# Register likes events
			for likes_event in data_received["likes"]:
				likes.append(likes_event["object"])
				likes_dialog_events[likes_event["object"]] = likes_event["text"]
			# Register dislikes events
			for dislikes_event in data_received["dislikes"]:
				dislikes.append(dislikes_event["object"])
				dislikes_dialog_events[dislikes_event["object"]] = dislikes_event["text"]		
			# Register objects and dialog events in the character
			character.intro_dialog_events = intro_dialog_events
			character.likes_dialog_events = likes_dialog_events
			character.dislikes_dialog_events = dislikes_dialog_events
			character.likes = likes
			character.dislikes = dislikes

		else:
			print("Unexpected data of type ", typeof(data_received))
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

