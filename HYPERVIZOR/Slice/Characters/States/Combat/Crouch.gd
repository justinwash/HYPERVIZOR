# Combat/Crouch
extends Node2D

var move_dir = 0

func update_state(player):
	if  (Input.is_action_pressed("player_right")):
		player.sprite.set_scale(Vector2(1,1))
		move_dir = 0.5
	elif Input.is_action_pressed("player_left"):
		player.sprite.set_scale(Vector2(-1,1))
		move_dir = -0.5

	player.move_and_slide(Vector2(player.physics.COMBAT_MOVE_SPEED * move_dir, player.physics.COMBAT_GRAVITY), Vector2(0,-1))

	if Input.is_action_pressed("player_up"):
		player.current_state = player.states.combat["jump"]

	if (!Input.is_action_pressed("player_down")):
		player.current_state = player.states.combat["idle"]
