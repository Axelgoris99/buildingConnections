# initialization.gd
extends State

func enter(_msg := {}) -> void:
	score_csv()
	handle_taste_characters()
	state_machine.transition_to("idle")

func score_csv():
	var node = CsvScore.new()
	node.set_name("csv_score")
	node.add_to_group("csv")
	add_child(node)

func handle_taste_characters():
	pass
