extends Node
var assigned_chairs = []

func get_chairs():
	for chair in get_children():
		if(chair.is_in_group("chairs")):
			assigned_chairs.append(chair)
	return assigned_chairs
