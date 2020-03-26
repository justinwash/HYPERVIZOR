extends Sprite

var t = 0
var activated = false
var activated_t = 0

export var BLINK_TIME = 0.25

func _physics_process(delta):
	t += 1
	if activated:
		if t % 10 == 0 and (t - activated_t) / 60 <= BLINK_TIME:
			toggle_visibility()
		elif (t - activated_t) / 60 > BLINK_TIME:
			activated = false

func toggle_visibility():
	self.visible = !self.visible
	
func activate():
	activated_t = t
	activated = true
