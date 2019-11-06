extends KinematicBody2D

var states
var current_state

func _ready():
	states = {
		"idle": $States/Idle,
		"walk": $States/Walk
	}

	current_state = states["idle"]

func _physics_process(delta):
	current_state.update_state(self)
