extends Node2D

export (NodePath) var PARENT_PATH
var parent

func _ready():
	parent = get_node(PARENT_PATH)
	
func ready_state(this):
	this.anim.play("Combat.Defeat")
	
func update_state(this):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Combat.Defeat"):
		get_tree().call_group("PC", "exit_combat_mode")
		parent.queue_free()
