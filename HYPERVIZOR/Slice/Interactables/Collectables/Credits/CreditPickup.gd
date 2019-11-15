extends Node2D

var halted = false
var value = 10

func activate():
	if halted:
		return
		
func on_enter(player):
	player.inventory.CREDITS += value
	print("picked up " + str(value) + " CREDITs")
	print("CREDITs: " + str(player.inventory.CREDITS))
	self.queue_free()