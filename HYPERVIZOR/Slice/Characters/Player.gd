extends KinematicBody2D

var sprite
var physics
var vitals
var inventory

var states
var last_state
var current_state

func _ready():
	sprite = $PolySprite
	physics = $Physics
	vitals = $Vitals
	inventory = $Inventory

	states = {
		"idle": $States/Idle,
		"walk": $States/Walk,
		"jump": $States/Jump
	}

	current_state = states["idle"]
	last_state = states["idle"]

	print("current state: " + current_state.name)

func _physics_process(delta):
	if current_state != last_state:
		print("current state: " + current_state.name)
		last_state = current_state
		if current_state.has_method("ready_state"):
			current_state.ready_state(self)

	current_state.update_state(self)
