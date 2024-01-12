# initialization.gd
extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	print("Hello")

func handle_input(_event: InputEvent):
	state_machine.transition_to("Placement")
