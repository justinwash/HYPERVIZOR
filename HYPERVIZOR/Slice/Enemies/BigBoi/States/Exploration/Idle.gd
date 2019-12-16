# Exploration/Idle
extends Node2D

func ready_state(this):
	this.anim.play("Exploration.Idle")
	
func update_state(this):
	this.move_and_slide(Vector2(0, this.physics.GRAVITY), Vector2(0,-1))

