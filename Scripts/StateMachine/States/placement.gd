# initialization.gd
extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	$PlacementTimer.start()
	print("Placement")

func handle_input(_event: InputEvent):
	await Timer

func _on_timer_timeout():
	state_machine.transition_to("Initialization")
	pass # Replace with function body.
