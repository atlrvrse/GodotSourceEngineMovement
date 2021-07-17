# This is all more or less copied from here 
# https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/sp/src/game/shared/gamemovement.cpp
extends "res://Scripts/Player/player_input.gd"
class_name Player

# warning-ignore:unused_argument
func _physics_process(delta):
	Move(delta)
	CrouchCamera()
	
func CheckVelocity():
	# bound velocity
	# Bound it.
	if vel.length() > ply_maxvelocity:
		vel = ply_maxvelocity
			
	elif vel.length() < -ply_maxvelocity:
		vel = -ply_maxvelocity

func Move(delta):
	if noclip == true:
		NoclipMove(delta)
		
	elif is_on_floor() and noclip == false:
		WalkMove(delta)
	else:
		AirMove(delta)
	
	if Input.is_action_just_pressed("in_jump"):
		CheckJumpButton()
		
	CheckVelocity()
	
	vel = move_and_slide_with_snap(vel, snap, Vector3.UP, true, 4, ply_maxslopeangle, false)
	
func CrouchCamera():
	
	# Crouching
	if crouching:
		crouched = true
	if !crouching:
		crouched = false
	
	if is_on_floor() and crouched:
		view.translation = view.translation.linear_interpolate(Vector3(0, ply_crouchedheight, 0), ply_crouchlerpweight)
	if is_on_floor() and !crouched:
		view.translation = view.translation.linear_interpolate(Vector3(0, ply_crouchstanceheight, 0), ply_crouchlerpweight)
	if !is_on_floor() and crouched:
		view.translation.y = ply_crouchedheight
	
func WalkMove(delta):
	var forward = Vector3.FORWARD
	var side = Vector3.LEFT
	
	forward = forward.rotated(Vector3.UP, view.rotation.y)
	side = side.rotated(Vector3.UP, view.rotation.y)
	
	forward = forward.normalized()
	side = side.normalized()
	
	snap = -get_floor_normal()
	
	var fmove = forwardmove
	var smove = sidemove
	
	var wishvel = side * smove + forward * fmove
	
	Friction(delta)
		
	# Zero out y value
	wishvel.y = 0
	
	var wishdir = wishvel.normalized()
	# VectorNormalize in the original source code doesn't actually return the length of the normalized vector
	# It returns the length of the vector before it was normalized
	var wishspeed = wishvel.length()
	
	# clamp to game defined max speed
	if wishspeed != 0.0 and wishspeed > maxspeed:
		wishvel *= maxspeed / wishspeed
		wishspeed = maxspeed
	
	Accelerate(wishdir, wishspeed, ply_accelerate, delta)
	
	$top.set_disabled(false)
	$bottom.set_disabled(false)
	
func AirMove(delta):
	
	var forward = Vector3.FORWARD
	var side = Vector3.LEFT
	
	forward = forward.rotated(Vector3.UP, $view.rotation.y)
	side = side.rotated(Vector3.UP, $view.rotation.y)
	
	forward = forward.normalized()
	side = side.normalized()
	
	var fmove = forwardmove
	var smove = sidemove
	
	snap = Vector3.ZERO
	vel.y -= ply_gravity * delta
	
	var wishvel = side * smove + forward * fmove
	
	# Zero out y value
	wishvel.y = 0
	
	var wishdir = wishvel.normalized()
	# VectorNormalize in the original source code doesn't actually return the length of the normalized vector
	# It returns the length of the vector before it was normalized
	var wishspeed = wishvel.length()
	
	# clamp to game defined max speed
	if wishspeed != 0.0 and wishspeed > maxspeed:
		wishvel *= maxspeed / wishspeed
		wishspeed = maxspeed
	
	AirAccelerate(wishdir, wishspeed, ply_airaccelerate, delta)
	
	$top.set_disabled(false)
	$bottom.set_disabled(false)
	
func NoclipMove(delta):
	var forward = Vector3.FORWARD
	var side = Vector3.LEFT
	var up = Vector3.UP
	
	forward = forward.rotated(Vector3.UP, $view.rotation.y)
	side = side.rotated(Vector3.UP, $view.rotation.y)
	
	forward = forward.normalized()
	side = side.normalized()
	
	var fmove = forwardmove
	var smove = sidemove
	var umove = xlook
	
	var wishvel = side * smove + forward * fmove
	if fmove != 0:
		wishvel.y += $view.rotation_degrees.x * 50
	
	var wishdir = wishvel.normalized()
	# VectorNormalize in the original source code doesn't actually return the length of the normalized vector
	# It returns the length of the vector before it was normalized
	var wishspeed = wishvel.length()
	
	# clamp to game defined max speed
	if wishspeed != 0.0 and wishspeed > maxspeed:
		wishvel *= maxspeed / wishspeed
		wishspeed = maxspeed
		
	Friction(delta)
	
	Accelerate(wishdir, wishspeed, ply_maxacceleration, delta)

	$top.set_disabled(true)
	$bottom.set_disabled(true)
	
func Accelerate(wishdir, wishspeed, accel, delta):
	# See if we are changing direction a bit
	var currentspeed = vel.dot(wishdir)
	# Reduce wishspeed by the amount of veer.
	var addspeed = wishspeed - currentspeed
	
	# If not going to add any speed, done.
	if addspeed <= 0:
		return

	# Determine amount of accleration.
	var accelspeed = accel * wishspeed * delta
	
	# Cap at addspeed
	accelspeed = min(accelspeed, addspeed)
	
	for i in range(3):
		# Adjust velocity.
		vel += accelspeed * wishdir
	
func AirAccelerate(wishdir, wishspeed, accel, delta):
	# cap speed
	wishspeed = min(wishspeed, ply_airspeedcap)
	# See if we are changing direction a bit
	var currentspeed = vel.dot(wishdir)
	# Reduce wishspeed by the amount of veer.
	var addspeed = wishspeed - currentspeed
	
	# If not going to add any speed, done.
	if addspeed <= 0:
		return

	# Determine amount of accleration.
	var accelspeed = accel * wishspeed * delta 
	
	# Cap at addspeed
	accelspeed = min(accelspeed, addspeed)
	
	for i in range(3):
		# Adjust velocity.
		vel += accelspeed * wishdir
	
func Friction(delta):
	# If we are in water jump cycle, don't apply friction
	#if (player->m_flWaterJumpTime)
	#	return

	# Calculate speed
	var speed = vel.length()
	
	# If too slow, return
	if speed < 0:
		return

	var drop = 0

	# apply ground friction
	var friction = ply_friction

	# Bleed off some speed, but if we have less than the bleed
	#  threshold, bleed the threshold amount.
	var control = ply_stopspeed if speed < ply_stopspeed else speed
	# Add the amount to the drop amount.
	drop += control * friction * delta

	# scale the velocity
	var newspeed = speed - drop
	if newspeed < 0:
		newspeed = 0

	if newspeed != speed:
		# Determine proportion of old speed we are using.
		newspeed /= speed
		# Adjust velocity according to proportion.
		vel *= newspeed

func CheckJumpButton():
	snap = Vector3.ZERO
			
	if not is_on_floor():
			return
	
	var flGroundFactor = 1.0
	var flMul = sqrt(2 * ply_gravity * ply_jumpheight)
	vel.y += flGroundFactor * flMul  # 2 * gravity * height
	
	# Add a little forward velocity based on your current forward velocity - if you are not sprinting.
	"""
	var vel2d = Vector2(vel.x, vel.z)
	var vecforward = Vector3.FORWARD
	vecforward = vecforward.rotated(Vector3.UP, $view.rotation.y)
	vecforward.y = 0
	vecforward = vecforward.normalized()
	# We give a certain percentage of the current forward movement as a bonus to the jump speed.  That bonus is clipped
	# to not accumulate over time.
	var flSpeedBoostPerc = 1.5
	var flSpeedAddition = abs(forwardmove * flSpeedBoostPerc)
	var flMaxSpeed = ply_maxspeed * flSpeedBoostPerc
	var flNewSpeed = flSpeedAddition + vel2d.length()
	
	# If we're over the maximum, we want to only boost as much as will get us to the goal speed
	if flNewSpeed > flMaxSpeed:
		flSpeedAddition -= flNewSpeed - flMaxSpeed

	if forwardmove < 0:
		flSpeedAddition *= -1.0

	# Add it on
	vel += vecforward * flSpeedAddition
	"""
