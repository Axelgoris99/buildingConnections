class_name DialogManager
extends Node

# Method to run the dialog for a given character.
# The character will give information only on given objects.
func run_dialog(character : Character, likes : Array, dislikes : Array):
	var timeline : DialogicTimeline = DialogicTimeline.new()
	var events : Array = []
	var text_event = DialogicTextEvent.new()
	text_event.text = '"' + character.intro_dialog_events[randi() % character.intro_dialog_events.size()] + '"'
	text_event.character = load(character.profile_path)
	events.append(text_event)
	for like in likes:
		var like_event = DialogicTextEvent.new()
		like_event.text = '"' + character.likes_dialog_events[like] + '"'
		like_event.character = load(character.profile_path)
		events.append(like_event)
	for dislike in dislikes:
		var dislike_event = DialogicTextEvent.new()
		dislike_event.text = '"' + character.dislikes_dialog_events[dislike] + '"'
		dislike_event.character = load(character.profile_path)
		events.append(dislike_event)
	timeline.events = events
	timeline.events_processed = true
	Dialogic.start(timeline)
