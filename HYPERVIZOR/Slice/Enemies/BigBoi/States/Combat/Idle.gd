# Combat/Idle
extends Node2D

var t = 0

func ready_state(this):
	this.anim.play("Combat.Idle")
	
func update_state(this):
	t += 1
	if t % 20 == 0:
		randomize()
		var percent = randf()
		if (percent > 0.8):
			this.current_state = this.states.combat["attack"]
	else:
		this.move_and_slide(Vector2(0, this.physics.GRAVITY), Vector2(0,-1))

