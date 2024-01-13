class_name CsvScore
extends Node
var score_grid: Array = []
var index_reference: Dictionary = {}

func _ready():
	var file = FileAccess.open("res://characters/scoreGrid.csv", FileAccess.READ)
	# the first line is not useful
	file.get_csv_line()
	var index = 0
	while !file.eof_reached():
		read_line(file.get_csv_line(";"), index)
		index += 1
		
func read_line(line, index):
	if(!line[0]):
		return
	index_reference[line[0]] = index
	line.remove_at(0)
	var intermediate_array: Array = []
	for score in line:
		intermediate_array.append(int(score))
	score_grid.append(intermediate_array)

func find_index_object(object_name):
	return index_reference[object_name]
	
