extends Node

var timeline : DialogicTimeline = DialogicTimeline.new()
var intro_dialog_events : Array = []
var likes_dialog_events = {}
var dislikes_dialog_events = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_character_dialog_events("pirate")
	var events : Array = []
	var text_event = DialogicTextEvent.new()
	text_event.text = '"' + intro_dialog_events[0] + '"'
	text_event.character = load("res://dialogs/pirate.dch")
	events.append(text_event)
	timeline.events = events
	timeline.events_processed = true
	Dialogic.start(timeline)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent):
# Check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		Dialogic.start('pirate_timeline')
		get_viewport().set_input_as_handled()

# Load dialog events from a json file and store them
func _load_character_dialog_events(character_name: String):
	var dialog_events = {}
	var json = JSON.new()
	var dialog_file = FileAccess.open("res://dialogs/" + character_name + ".json", FileAccess.READ)
	var json_string = dialog_file.get_as_text()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			print(data_received) # Prints array
			# At this point all dialog events of the character are stored in the distionary data_received
			# Now we need to split them into intro, likes and dislikes
			# Register intro events
			for intro_event in data_received["intro"]:
				intro_dialog_events.append(intro_event["value"])
			print("intro dialog found: ", intro_dialog_events.size())
			# Register likes events
			for likes_event in data_received["likes"]:
				likes_dialog_events[likes_event["object"]] = likes_event["text"]
			# Register dislikes events
			for dislikes_event in data_received["dislikes"]:
				dislikes_dialog_events[dislikes_event["object"]] = dislikes_event["text"]		
		
		else:
			print("Unexpected data of type ", typeof(data_received))
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

	
		

