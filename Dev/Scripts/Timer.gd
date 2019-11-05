extends Node2D

export(NodePath) var TIMER
onready var timer = get_node(TIMER)

var frame = 0
var time = 99

func _physics_process(delta):
	frame += 1
