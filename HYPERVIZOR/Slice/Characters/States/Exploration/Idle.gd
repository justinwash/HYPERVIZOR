extends Node2D

func update_state(player):
	if (Input.is_action_pressed("player_down")):
		player.current_state = player.states.exploration["crouch"]
		
	if (Input.is_action_pressed("player_up")):
		player.current_state = player.states.exploration["jump"]

	elif (Input.is_action_pressed("player_right")
	or  Input.is_action_pressed("player_left")):
		player.current_state = player.states.exploration["walk"]

	else:
		player.move_and_slide(Vector2(0, player.physics.GRAVITY), Vector2(0,-1))
