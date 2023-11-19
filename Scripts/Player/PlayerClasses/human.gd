extends Player
func Move(delta):
	
	if crouched:
		maxspeed = 9
	else:	
		maxspeed = ply_maxspeed
		#print(maxspeed)
		
		
	if Input.is_action_just_pressed("in_crouch"):
		Crouch()
		
	.Move(delta)
	#var a =Vector3(0, 100, 0)

	#move_and_slide_with_snap(a, snap, Vector3.UP, true, 4, ply_maxslopeangle, false)

func Crouch():
	if is_on_floor():
		var a = Vector3(0,-200, 0)
		move_and_slide_with_snap(a, snap, Vector3.UP, true, 4, ply_maxslopeangle, false)
	else:
		var b =Vector3(0, 200, 0)
		move_and_slide_with_snap(b, snap, Vector3.UP, true, 4, ply_maxslopeangle, false)
