extends Node2D

var frame = 0
var input_buffer = []

# Button Inputs (updated every frame)
var dpad_input := 0
var btn_input := 0

func _physics_process(delta):
	frame += 1
	update_dpad()
	update_btn()
	update_input_buffer(update_dpad(), update_btn(), frame)

func update_dpad():
	if Input.is_action_pressed("player_left"):
		if Input.is_action_pressed("player_up"):
			dpad_input = 7
		elif Input.is_action_pressed("player_down"):
			dpad_input = 1
		elif Input.is_action_pressed("player_right"):
			dpad_input = 5
		else:
			dpad_input = 4
	elif Input.is_action_pressed("player_right"):
		if Input.is_action_pressed("player_up"):
			dpad_input = 9
		elif Input.is_action_pressed("player_down"):
			dpad_input = 3
		else:
			dpad_input = 6
	elif Input.is_action_pressed("player_down"):
		if Input.is_action_pressed("player_up"):
			dpad_input = 8
		else:
			dpad_input = 2
	elif Input.is_action_pressed("player_up"):
			dpad_input = 8
	else:
			dpad_input = 5
	return dpad_input

func update_btn():
	if Input.is_action_just_pressed("player_btn1"):
		if Input.is_action_pressed("player_btn2"):
			btn_input = 12
		elif Input.is_action_pressed("player_btn3"):
			btn_input = 13
		elif Input.is_action_pressed("player_btn4"):
			btn_input = 14
		else:
			btn_input = 1
	elif Input.is_action_just_pressed("player_btn2"):
		if Input.is_action_pressed("player_btn3"):
			btn_input = 23
		elif Input.is_action_pressed("player_btn4"):
			btn_input = 24
		else:
			btn_input = 2
	elif Input.is_action_just_pressed("player_btn3"):
		if Input.is_action_pressed("player_btn4"):
			btn_input = 34
		else:
			btn_input = 3
	elif Input.is_action_just_pressed("player_btn4"):
		btn_input = 4
	else:
		btn_input = 0
	return btn_input

func update_input_buffer(dpad, btn, frame_state):
	var temp_buffer = input_buffer
	var to_be_removed = []

	if temp_buffer.size() > 0:
		if dpad != temp_buffer.back().dpad_state:
			input_buffer.append(InputState.new(dpad, btn, frame_state))

		if btn != temp_buffer.back().btn_state:
			input_buffer.append(InputState.new(dpad, btn, frame_state))

		for i in range(0, temp_buffer.size()):
			if frame - temp_buffer[i].frame_state >= 60:
				to_be_removed.append(i)

		for k in to_be_removed:
			input_buffer.remove(k)

	else:
		input_buffer.append(InputState.new(dpad, btn, frame_state))

func flush_input_buffer():
	input_buffer = []

func find_buffered_dpad_sequence(buffer, dpad_sequence, window):
	var temp_buffer = buffer
	var dpad_sequence_found = null

	if dpad_sequence != null:
		if temp_buffer.size() >= dpad_sequence.size():
			for i in range(1, dpad_sequence.size() + 1):
				if temp_buffer[-i].dpad_state != dpad_sequence[-i] || frame - temp_buffer[-i].frame_state > window:
					dpad_sequence_found = false
			if dpad_sequence_found != false:
				dpad_sequence_found = true

	if dpad_sequence_found:
		return true
	else:
		return false

func find_buffered_btn(buffer, btn, window):
	var temp_buffer = buffer

	for s in temp_buffer:
		if btn.has(s.btn_state) && frame - s.frame_state <= window:
			return s.btn_state

	return null

class InputState:
	var dpad_state := 5
	var btn_state := 0
	var frame_state := 0

	func _init(dpad, btn, frame):
		dpad_state = dpad
		btn_state = btn
		frame_state = frame
