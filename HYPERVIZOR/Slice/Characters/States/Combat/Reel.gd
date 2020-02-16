#warnings-disable
extends Node2D

func ready_state(player):
	if player.anim.current_animation == "Combat.Reel":
		player.anim.seek(0, true)
	else:
		player.anim.play("Combat.Reel")
	
func update_state(this):
	this.move_and_slide(Vector2(0, this.physics.GRAVITY), Vector2(0,-1))

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Combat.Reel"):
		owner.current_state = owner.states.combat["idle"]