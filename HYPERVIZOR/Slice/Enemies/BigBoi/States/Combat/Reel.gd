#warnings-disable
extends Node2D

func ready_state(this):
	if this.anim.current_animation == "Combat.Reel":
		this.anim.seek(0, true)
	else:
		this.anim.play("Combat.Reel")
	
func update_state(this):
	this.move_and_slide(Vector2(0, this.physics.GRAVITY), Vector2(0,-1))

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Combat.Reel"):
		owner.current_state = owner.states.combat["idle"]
