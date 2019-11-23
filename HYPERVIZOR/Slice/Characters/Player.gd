extends KinematicBody2D

# State Variables
var sprite
var physics
var vitals
var inventory
var camera

var states
var last_state
var current_state

func _ready():
	sprite = $PolySprite
	physics = $Physics
	vitals = $Vitals
	inventory = $Inventory
	camera = $CameraAnchor

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
	# delete below
	$Label.text = current_mode
	# delete above
	
	# this currently does not work, even though it seems like it should according to this:
	# https://godotengine.org/qa/10929/2d-camera-follow-two-players
	if current_mode == "combat" and current_target != null:
		camera.global_position = (current_target.global_position + self.global_position) / 2
	
	else:
		camera.global_position = self.global_position
		
	if current_state != last_state:
		print("current state: " + current_state.name)
		last_state = current_state
		if current_state.has_method("ready_state"):
			current_state.ready_state(self)

	current_state.update_state(self)
	
# Mode Variables
var current_target
var current_mode = "exploration"

# Mode Methods
func enter_combat_mode(target):
	for interactable in get_tree().get_nodes_in_group("Interactables"):
		interactable.halted = true
		
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.halted = true
		
	current_target = target
	current_target.halted = false
	current_target.current_state = current_target.states.combat["idle"]
	
	current_state = states.combat["idle"]
	current_mode = "combat"
	
func exit_combat_mode():
	for interactable in get_tree().get_nodes_in_group("Interactables"):
		interactable.halted = false
		
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.halted = false
	
	current_state = states.exploration["idle"]
	current_mode = "exploration"

# Utility Variables
var nearby_interactables = []

# Utility Methods
func can_interact():
	return nearby_interactables.size() != 0

# Signals
func _on_InteractionRadius_area_entered(area):
	if area.owner.is_in_group("Enemies"):
		enter_combat_mode(area.owner)
		return
	
	if area.owner.has_method("on_enter"):
		area.owner.on_enter(self)
	nearby_interactables.push_front(area.owner)
	print(area.owner.name + " nearby")

func _on_InteractionRadius_area_exited(area):
	if area.owner != null and area.owner.has_method("on_exit"):
		area.owner.on_exit(self)
		nearby_interactables.remove(nearby_interactables.find(null))
		print(area.owner.name + " not near anymore")
