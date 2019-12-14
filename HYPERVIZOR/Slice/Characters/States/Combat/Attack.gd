# Combat/Attack
extends Node2D

var animation

func ready_state(player):
	# Find the correct attack animation and play it
	var animation = player.attacks.get_node("5+A").ANIMATION
	
	print("playing animation: " + animation)
	player.anim.play(animation)

func update_state(player):
	pass

func _on_animation_finished(anim_name):
	var player = get_node("../../../")
	player.current_state = player.states.combat["idle"]
