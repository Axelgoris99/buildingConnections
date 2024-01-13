extends Node
var assigned_chairs: Array = []

func get_chairs():
	if(assigned_chairs.size() > 0):
		return assigned_chairs
	for chair in get_children():
		if(chair.is_in_group("chairs")):
			assigned_chairs.append(chair)
	return assigned_chairs
