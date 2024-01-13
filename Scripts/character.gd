class_name Character
extends Node

var current_chair
var likes = []
var dislikes = []
@export var display_name: String = "test"
func set_chair(chair):
	current_chair = chair
	current_chair.set_character(self)

func remove_chair():
	if(!current_chair):
		return
	current_chair.set_character(null)
	current_chair = null

# Path to the character's profile, .dch file
var profile_path : String = ""
# Store the intro texts
var intro_dialog_events : Array = []
# Store the liked objects and assorted texts
var likes_dialog_events : Dictionary = {}
# Store the disliked objects and assorted texts
var dislikes_dialog_events : Dictionary = {}
# Records which likes/dislikes the player has become aware of
var known_objects : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Add objects to the list of objects the player is aware of 
func add_known_objects(objects : Array):
	known_objects.append_array(objects)
