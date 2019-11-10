extends Node2D

func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true