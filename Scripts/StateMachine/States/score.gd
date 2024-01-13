# score.gd
extends State

var score_node: CsvScore
# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	print("score")
	score_node = get_tree().get_nodes_in_group("csv")[0]
	calculate_total_score()
	
func calculate_total_score():
	var tables = get_tables()
	var score = 0
	for table in tables:
		score += calculate_score_per_table(table)
	print(score)

func get_tables():
	return get_tree().get_nodes_in_group("tables")
	
func calculate_score_per_table(table):
	var score = 0
	var characters : Array = []
	for chair in table.get_chairs():
		if(!chair.current_character):
			continue
		characters.append(chair.current_character)
	for characterA in range(characters.size()):
		for characterB in range(characterA + 1, characters.size()):
			for likeA in characters[characterA].likes:
				for likeB in characters[characterB].likes:
					score += calculate_similar(likeA, likeB)
				for dislikeB in characters[characterB].dislikes:
					score += calculate_different(likeA, dislikeB)
			for dislikeA in characters[characterA].dislikes:
				for likeB in characters[characterB].likes:
					score += calculate_different(dislikeA, likeB)
				for dislikeB in characters[characterB].dislikes:
					score += calculate_similar(dislikeA, dislikeB)
	return score
	
# Calculate the score when two persons like or dislike the same thing
func calculate_similar(a, b):
	var indexA = score_node.find_index_object(a)
	var indexB = score_node.find_index_object(b)
	if indexA > indexB:
		return score_node.score_grid[indexA][indexB]
	else:
		return score_node.score_grid[indexB][indexA]
	
	
# Calculate the score when a likes and b dislikes the same thing
func calculate_different(a,b):
	var indexA = score_node.find_index_object(a)
	var indexB = score_node.find_index_object(b)
	if indexA > indexB:
		return - score_node.score_grid[indexB][indexA]
	else:
		return - score_node.score_grid[indexA][indexB]
