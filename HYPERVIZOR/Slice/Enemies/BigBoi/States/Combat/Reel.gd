extends Node2D

export (NodePath) var PARENT_PATH
var parent

func _ready():
	parent = get_node(PARENT_PATH)
	
func ready_state(this):
	this.anim.play("Combat.Reel")
	
func update_state(this):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Combat.Reel"):
		parent.current_state = parent.states.combat["idle"]
