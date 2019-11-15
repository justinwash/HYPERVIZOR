# Combat/Idle
extends Node2D

func update_state(this):
	this.move_and_slide(Vector2(-100, this.physics.GRAVITY), Vector2(0,-1))

