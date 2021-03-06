# Combat/Walk
extends Node2D

var move_dir = 0

func ready_state(player):
	player.anim.play("Combat.Walk")
	
func update_state(player):
	var temp_buffer = player.input.input_buffer
	
	if player.input.find_buffered_dpad_sequence(temp_buffer, [6,5,6], 16) or player.input.find_buffered_dpad_sequence(temp_buffer, [4,5,4], 16):
		player.current_state = player.states.combat["dash"]

	elif  (Input.is_action_pressed("player_right")):
		move_dir = 1
	elif Input.is_action_pressed("player_left"):
		move_dir = -1

	player.move_and_slide(Vector2(player.physics.COMBAT_MOVE_SPEED * move_dir, player.physics.COMBAT_GRAVITY), Vector2(0,-1))

	if (Input.is_action_pressed("player_down")):
		player.current_state = player.states.combat["crouch"]
		
	if Input.is_action_pressed("player_up"):
		player.current_state = player.states.combat["jump"]

	if (!Input.is_action_pressed("player_right") and !Input.is_action_pressed("player_left")):
		player.current_state = player.states.combat["idle"]
