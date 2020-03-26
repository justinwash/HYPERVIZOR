extends Node2D

var halted = false
var anim_player
var is_open = false

func _ready():
	anim_player = $AnimationPlayer
	
func on_enter(player):
	$Icon.visible = true
	
func on_exit(player):
	$Icon.activated_t = 0
	$Icon.visible = false

func activate():
	if halted:
		return
		
	$Icon.activate()
		
	if is_open == false:
		anim_player.play("Open")
		is_open = true
	else:
		anim_player.play("Close")
		is_open = false
