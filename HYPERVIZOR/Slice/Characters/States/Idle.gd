extends Node2D

func update_state(player):
	if (Input.is_action_pressed("player_up")):
		player.current_state = player.states["jump"]

	elif (Input.is_action_pressed("player_right")
	or  Input.is_action_pressed("player_left")):
		player.current_state = player.states["walk"]

	else:
		player.move_and_slide(Vector2(0, player.stats.GRAVITY), Vector2(0,-1))

