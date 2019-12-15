extends KinematicBody2D

var halted = false

export var HEALTH = 100
export var xp_reward = 25

# State Variables
var sprite
var physics
var vitals

var states
var last_state
var current_state

func _ready():
	physics = $Physics
	vitals = $Vitals

	states = {
		combat = {
			"idle": $States/Combat/Idle,
			"reel": $States/Combat/Reel
		},
		exploration = {
			"idle": $States/Exploration/Idle,
		}
	}

	current_state = states.exploration["idle"]
	last_state = states.exploration["idle"]

	print("current state: " + current_state.name)

func _physics_process(delta):
	if halted:
		return
		
	if current_state != last_state:
		print("current state: " + current_state.name)
		last_state = current_state
		if current_state.has_method("ready_state"):
			current_state.ready_state(self)

	current_state.update_state(self)
	
func on_enter(player):
	pass
	
func activate():
	pass
		
func on_exit(player):
	pass
	
func _on_Hurtbox_area_entered(area):
	HEALTH -= area.current_attack.DAMAGE
	if HEALTH <= 0:
		queue_free()
		area.owner.exit_combat_mode()
	# current_state = states.combat["reel"]
