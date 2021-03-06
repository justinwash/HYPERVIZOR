#warnings-disable
extends Node2D

var halted = false
var anim_player
var is_open = false

func _ready():
	anim_player = $AnimationPlayer
	
func on_enter(player):
	$Icon.visible = true

func on_exit(player):
	if halted:
		return
	$Window/TextLog.visible = false
	$Window/Border.visible = false
	is_open = false
	$Icon.activated_t = 0
	$Icon.visible = false
	
func activate():
	if halted:
		return
	
	$Icon.activate()
		
	if is_open == false:
		$Window/TextLog.visible = true
		$Window/Border.visible = true
		is_open = true
