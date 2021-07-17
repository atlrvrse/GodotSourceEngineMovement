extends "res://Scripts/Player/player_shared.gd"

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		InputMouse(event)
		
	if Input.is_action_pressed("in_crouch"):
		crouching = true
	elif Input.is_action_just_released("in_crouch"):
		crouching = false

# warning-ignore:unused_argument
func _process(delta):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		InputKeys()
		ViewAngles(delta)
	
func InputMouse(event):
	xlook += -event.relative.y * ply_xlookspeed 
	ylook += -event.relative.x * ply_ylookspeed
	xlook = clamp(xlook, ply_maxlookangle_down, ply_maxlookangle_up)
	
func ViewAngles(delta):
	$view.rotation_degrees.x = xlook
	$view.rotation_degrees.y = ylook
	
func InputKeys():
	sidemove += int(ply_sidespeed) * (int(Input.get_action_strength("in_left") * 50))
	sidemove -= int(ply_sidespeed) * (int(Input.get_action_strength("in_right") * 50))
	
	forwardmove += int(ply_forwardspeed) * (int(Input.get_action_strength("in_forward") * 50))
	forwardmove -= int(ply_backspeed) * (int(Input.get_action_strength("in_back") * 50))
	
	# Clamp that shit so it doesn't go too high
	if Input.is_action_just_released("in_left") or Input.is_action_just_released("in_right"):
		sidemove = 0
	else:
		sidemove = clamp(sidemove, -4096, 4096)
	if Input.is_action_just_released("in_up") or Input.is_action_just_released("in_down"):
		upmove = 0
	else:
		upmove = clamp(upmove, -4096, 4096)
	if Input.is_action_just_released("in_forward") or Input.is_action_just_released("in_back"):
		forwardmove = 0
	else:
		forwardmove = clamp(forwardmove, -4096, 4096)
