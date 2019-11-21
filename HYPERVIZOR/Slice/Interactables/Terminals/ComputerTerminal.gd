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
		$TextLog.visible = true
		is_open = true
		
func on_exit(player):
	if halted:
		return
	$TextLog.visible = false
	is_open = false
