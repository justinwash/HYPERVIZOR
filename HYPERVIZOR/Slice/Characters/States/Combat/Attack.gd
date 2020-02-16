#warnings-disable
# Combat/Attack
extends Node2D

var animation

func ready_state(player):
	var last_input = player.input.get_last_pressed()
	# print("last input: ", last_input.dpad_state, ",", last_input.btn_state, ",", last_input.frame_state)
	var dpad = last_input.dpad_state
	var btn = last_input.btn_state
	
#	print(dpad, " ", btn)
	
	if btn != 0:
		player.hitbox.current_attack = player.attacks.get_node(str(dpad) + "+" + str(btn))
	else:
		player.current_state = player.states.combat["idle"]
		player.hitbox.current_attack = null
		return
	# Find the correct attack animation and play it
	var animation = player.hitbox.current_attack.ANIMATION
	
#	print("playing animation: " + animation)
	player.anim.play(animation)

func update_state(player):
	pass

func _on_animation_finished(anim_name):
	var player = get_node("../../../")
	player.current_state = player.states.combat["idle"]
