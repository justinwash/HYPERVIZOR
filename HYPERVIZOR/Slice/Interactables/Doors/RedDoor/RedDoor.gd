extends Node2D

var halted = false
var anim_player
var is_open = false

func _ready():
	anim_player = $AnimationPlayer
	
func activate():
	if halted:
		return
		
	if is_open == false:
		anim_player.play("Open")
		is_open = true
	else:
		anim_player.play("Close")
		is_open = false
