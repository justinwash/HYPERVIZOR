# Exploration/Idle
extends Node2D

func ready_state(player):
	player.anim.play("Exploration.Idle")
	
func update_state(player):
	if (Input.is_action_pressed("player_down")):
		player.current_state = player.states.exploration["crouch"]
		
	if (Input.is_action_pressed("player_up")):
		player.current_state = player.states.exploration["jump"]

	elif (Input.is_action_pressed("player_right")
	or  Input.is_action_pressed("player_left")):
		player.current_state = player.states.exploration["walk"]

	else:
		player.move_and_slide(Vector2(0, player.physics.EXPLORATION_GRAVITY), Vector2(0,-1))
		
		if Input.is_action_just_pressed("interact"):
			if player.can_interact():
				player.nearby_interactables[0].activate()
			

