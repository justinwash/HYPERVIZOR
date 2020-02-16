# Combat/Idle
extends Node2D

var input

func ready_state(player):
	player.anim.play("Combat.Idle")
	input = player.input
	
func update_state(player):
	# below is placeholder stuff
	if (Input.is_action_pressed("kill")):
		if player.current_target != null and player.current_mode == "combat":
			player.inventory.XP += player.current_target.xp_reward
#			print("killing current target: " + str(player.current_target.xp_reward) + "XP gained")
#			print("XP current: " + str(player.inventory.XP))
			player.current_target.free()
			player.current_target = null
			player.exit_combat_mode()
	# above is placeholder stuff
	
	if (player.current_target != null && is_instance_valid(player.current_target)):
		if player.current_target.global_position.x - player.global_position.x > 0:
			player.sprite.set_scale(Vector2(1,1))
			player.combat_components.set_scale(Vector2(1,1))
			
			player.current_target.sprite.set_scale(Vector2(-1,1))
			player.current_target.combat_components.set_scale(Vector2(-1,1))
			
		elif player.current_target.global_position.x - player.global_position.x <= 0:
			player.sprite.set_scale(Vector2(-1,1))
			player.combat_components.set_scale(Vector2(-1,1))
			
			player.current_target.sprite.set_scale(Vector2(1,1))
			player.current_target.combat_components.set_scale(Vector2(1,1))
		
	if (input.btn_input != 0):
		player.current_state = player.states.combat["attack"]
		
	if (Input.is_action_pressed("player_down")):
		player.current_state = player.states.combat["crouch"]
		
	if (Input.is_action_pressed("player_up")):
		player.current_state = player.states.combat["jump"]

	if (Input.is_action_pressed("player_right") or Input.is_action_pressed("player_left")):
		player.current_state = player.states.combat["walk"]

	else:
		player.move_and_slide(Vector2(0, player.physics.COMBAT_GRAVITY), Vector2(0,-1))

