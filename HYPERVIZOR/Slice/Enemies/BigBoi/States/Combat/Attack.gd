#warnings-disable

# Combat/Attack
extends Node2D

func ready_state(this):
	this.hitbox.current_attack = this.attacks.get_node("5+A")
	# Find the correct attack animation and play it
	var animation = this.hitbox.current_attack.ANIMATION
	
#	print("playing animation: " + animation)
	this.anim.play(animation)

func update_state(this):
	this.move_and_slide(Vector2(0, this.physics.GRAVITY), Vector2(0,-1))

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Attack.5+A"):
		var this = get_node("../../../")
		this.current_state = this.states.combat["idle"]
