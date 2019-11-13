extends KinematicBody2D

# State Variables
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
		combat = {
			"idle": $States/Combat/Idle,
			"walk": $States/Combat/Walk,
			"jump": $States/Combat/Jump,
			"crouch": $States/Combat/Crouch
		},
		exploration = {
			"idle": $States/Exploration/Idle,
			"walk": $States/Exploration/Walk,
			"jump": $States/Exploration/Jump,
			"crouch": $States/Exploration/Crouch
		}
	}

	current_state = states.exploration["idle"]
	last_state = states.exploration["idle"]

	print("current state: " + current_state.name)

func _physics_process(delta):
	if current_state != last_state:
		print("current state: " + current_state.name)
		last_state = current_state
		if current_state.has_method("ready_state"):
			current_state.ready_state(self)

	current_state.update_state(self)

# Utility Variables
var nearest_interactable

# Utility Methods
func can_interact():
	return nearest_interactable != null

func _on_InteractionRadius_area_entered(area):
	nearest_interactable = area.owner
	print(area)
	print('entered')


func _on_InteractionRadius_area_exited(area):
	nearest_interactable = null
	print(area)
	print('exited')
