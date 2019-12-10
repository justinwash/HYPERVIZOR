# Exploration/Crouch
extends Node2D

var move_dir = 0

func ready_state(player):
	player.anim.play("Exploration.Crouch")

func update_state(player):
	if  (Input.is_action_pressed("player_right")):
		player.sprite.set_scale(Vector2(1,1))
		player.anim.play("Exploration.CrouchWalk")
		move_dir = 0.5
	elif Input.is_action_pressed("player_left"):
		player.sprite.set_scale(Vector2(-1,1))
		player.anim.play("Exploration.CrouchWalk")
		move_dir = -0.5
	else:
		if player.anim.current_animation != "Exploration.Crouch":
			player.anim.play("Exploration.Crouch")
		move_dir = 0

	player.move_and_slide(Vector2(player.physics.EXPLORATION_MOVE_SPEED * move_dir, player.physics.EXPLORATION_GRAVITY), Vector2(0,-1))

	if Input.is_action_pressed("player_up"):
		player.current_state = player.states.exploration["jump"]

	if (!Input.is_action_pressed("player_down")):
		player.current_state = player.states.exploration["idle"]
