#warnings-disable
extends Node2D

func ready_state(player):
	player.anim.play("Combat.Reel")
	
func update_state(this):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Combat.Reel"):
		owner.current_state = owner.states.combat["idle"]