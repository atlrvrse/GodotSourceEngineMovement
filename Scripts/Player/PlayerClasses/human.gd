extends Player

var stopfuckingcrouchinginmidairyoufuckingcunt : bool = false

func Move(delta):
	
	if crouched:
		maxspeed = 9
	else:
		maxspeed = 15
		
	if is_on_floor():
		stopfuckingcrouchinginmidairyoufuckingcunt = false
		
	if !stopfuckingcrouchinginmidairyoufuckingcunt:
		Crouch()
		
	.Move(delta)

func Crouch():
	# dumbest shit i ever coded
	if crouching and !is_on_floor() and Input.is_action_just_pressed("in_crouch"):
		var up = collidertop.get_translation(); var down = colliderbottom.get_translation();
		
		# FUCKING CROUCHJUMPING
		self.global_translate(Vector3(0, up.distance_to(down) / 2.5, 0))
		self.global_translate(Vector3(0, down.distance_to(up) / 2.5, 0))
		
		if !is_on_floor():
			stopfuckingcrouchinginmidairyoufuckingcunt = true
	
