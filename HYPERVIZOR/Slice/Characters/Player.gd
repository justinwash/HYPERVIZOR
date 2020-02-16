#warnings-disable
extends KinematicBody2D

# State Variables
var sprite
var physics
var vitals
var inventory
var camera
var input
var anim
var attacks
var hitbox
var combat_components

# UI Variables (move these elsewhere pls)
var pc_health_meter
var enemy_health_meter
var CREDITs_meter
var XP_meter

var states
var last_state
var current_state

func _ready():
	sprite = $PolyPoser
	physics = $Physics
	vitals = $Vitals
	inventory = $Inventory
	camera = $CameraAnchor
	input = $Input
	anim = $AnimationPlayer
	attacks = $CombatComponents/Attacks
	hitbox = $CombatComponents/Hitbox
	pc_health_meter = $CameraAnchor/Camera/CombatUI/PCHealthMeter
	enemy_health_meter = $CameraAnchor/Camera/CombatUI/EnemyHealthMeter
	CREDITs_meter = $CameraAnchor/Camera/ExplorationUI/CREDITs
	XP_meter = $CameraAnchor/Camera/ExplorationUI/XP
	combat_components = $CombatComponents
	
	
	
	states = {
		combat = {
			"idle": $States/Combat/Idle,
			"walk": $States/Combat/Walk,
			"dash": $States/Combat/Dash,
			"jump": $States/Combat/Jump,
			"crouch": $States/Combat/Crouch,
			"attack": $States/Combat/Attack,
			"reel": $States/Combat/Reel
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

#	print("current state: " + current_state.name)
	if current_state.has_method("ready_state"):
			current_state.ready_state(self)

func _physics_process(delta):
	# delete below
	$CameraAnchor/Camera/GeneralUI/Label.text = "current mode: " + current_mode
	# delete above
	
	# UI stuff that needs to go elsewhere below
	pc_health_meter.value = vitals.HEALTH
	if (current_target != null && is_instance_valid(current_target)):
		enemy_health_meter.value = current_target.HEALTH
	CREDITs_meter.text = "CREDITs: " + str(inventory.CREDITs)
	XP_meter.text = "XP: " + str(inventory.XP)
	# UI stuff that need to go elsewhere above
	
	if current_state != last_state:
#		print("current state: " + current_state.name)
		last_state = current_state
		if current_state.has_method("ready_state"):
			current_state.ready_state(self)
	
	set_camera_position()
	current_state.update_state(self)
	
# Mode Variables
var current_target
var current_mode = "exploration"

# Mode Methods
func enter_combat_mode(target):
	pc_health_meter.visible = true
	enemy_health_meter.visible = true
	
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
	pc_health_meter.visible = false
	enemy_health_meter.visible = false
	
	for interactable in get_tree().get_nodes_in_group("Interactables"):
		interactable.halted = false
		
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.halted = false
	
	current_state = states.exploration["idle"]
	current_mode = "exploration"

func set_camera_position():
	if current_mode == "combat" and (current_target != null && is_instance_valid(current_target)):
		camera.global_position = (current_target.global_position + self.global_position) / 2
		camera.get_node("Camera").set_zoom(Vector2(0.8, 0.8))
	
	else:
		camera.global_position = self.global_position
		camera.get_node("Camera").set_zoom(Vector2(1, 1))

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
#	print(area.owner.name + " nearby")

func _on_InteractionRadius_area_exited(area):
	if area.owner != null and area.owner.has_method("on_exit"):
		area.owner.on_exit(self)
		nearby_interactables.remove(nearby_interactables.find(null))
#		print(area.owner.name + " not near anymore")

func _on_Hurtbox_area_entered(area):
	vitals.HEALTH -= area.current_attack.DAMAGE
	if vitals.HEALTH <= 0:
		pass
#		print("player RIP")
#		current_state = states.combat["defeat"]
	else:
		states.combat["reel"].ready_state(self)
		current_state = states.combat["reel"]
