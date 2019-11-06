extends KinematicBody2D

var states
var last_state
var current_state
var stats

func _ready():
	stats = $Stats

	states = {
		"idle": $States/Idle,
		"walk": $States/Walk
	}

	current_state = states["idle"]
	last_state = states["idle"]

	print("current state: " + current_state.name)

func _physics_process(delta):
	if current_state != last_state:
		print("current state: " + current_state.name)
		last_state = current_state

	current_state.update_state(self)
