# Combat/Walk
extends Node2D

var move_dir = 0

func update_state(player):
	if  (Input.is_action_pressed("player_right")):
		player.sprite.set_scale(Vector2(1,1))
		move_dir = 1
	elif Input.is_action_pressed("player_left"):
		player.sprite.set_scale(Vector2(-1,1))
		move_dir = -1

	player.move_and_slide(Vector2(player.physics.MOVE_SPEED * move_dir, player.physics.GRAVITY), Vector2(0,-1))

	if Input.is_action_pressed("player_up"):
		player.current_state = player.states.combat["jump"]

	if (!Input.is_action_pressed("player_right")
	and !Input.is_action_pressed("player_left")):
		player.current_state = player.states.combat["idle"]
