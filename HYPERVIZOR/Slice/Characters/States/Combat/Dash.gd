# Combat/Dash
extends Node2D

var move_dir = 0
var duration = 0

func ready_state(player):
	if player.input.input_buffer.back().dpad_state == 6:
		move_dir = 4

	elif player.input.input_buffer.back().dpad_state == 4:
		move_dir = -4

	duration = 16

func update_state(player):
	if duration > 0:
		player.move_and_slide(Vector2(player.physics.COMBAT_MOVE_SPEED * move_dir, player.physics.COMBAT_GRAVITY), Vector2(0,-1))
		duration -= 1
	else:
		player.current_state = player.states.combat["idle"]
