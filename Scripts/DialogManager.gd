class_name DialogManager
extends Node

# Method to run the dialog for a given character.
# The character will give information only on given objects.
func run_dialog(character : Character, likes : Array, dislikes : Array):
	var timeline : DialogicTimeline = DialogicTimeline.new()
	var events : Array = []
	var text_event = DialogicTextEvent.new()
	text_event.text = character.intro_dialog_events[randi() % character.intro_dialog_events.size()]
	var charprofile : DialogicCharacter = load("res://dialogs/" + character.name + ".dch")
	charprofile.display_name = character.display_name
	text_event.character = charprofile#load("res://dialogs/" + character.name + ".dch")
	events.append(text_event)
	for like in likes:
		var like_event = DialogicTextEvent.new()
		like_event.text = character.likes_dialog_events[like] 
		text_event.character = charprofile
		events.append(like_event)
	for dislike in dislikes:
		var dislike_event = DialogicTextEvent.new()
		dislike_event.text =  character.dislikes_dialog_events[dislike]
		text_event.character = charprofile
		events.append(dislike_event)
	timeline.events = events
	timeline.events_processed = true
	Dialogic.start(timeline)
