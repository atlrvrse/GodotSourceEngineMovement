extends KinematicBody
class_name Player

# Vectors
var vel = Vector3.ZERO
var snap = Vector3.DOWN

# ConVars
var ply_mousesensitivity = 2
var ply_maxlookangle_down = -90
var ply_maxlookangle_up = 90
var ply_ylookspeed = 0.3
var ply_xlookspeed = 0.3
var ply_sidespeed = 20
var ply_upspeed = 20
var ply_forwardspeed = 20
var ply_backspeed = 20
var ply_maxspeed = 32
var ply_accelerate = 20
var ply_airaccelerate = 20
var ply_noclipaccelerate = 20
var ply_airspeedcap = 15
var ply_friction = 4
var ply_stopspeed = 100
var ply_gravity = 140
var ply_maxslopeangle = deg2rad(45)
var ply_maxvelocity = 35000
var ply_jumpheight = 6

# Cheats
var noclip : bool

# Floats
var sidemove : float
var upmove : float
var forwardmove : float
var ylook : float
var xlook : float
var outstepheight : float

# Bools
var deadflag : bool

