extends KinematicBody

# Vectors
var vel = Vector3.ZERO
var snap = Vector3.DOWN

# Onready
onready var view = $view
onready var collidertop = $top
onready var colliderbottom = $bottom
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
var ply_accelerate = 10
var ply_airaccelerate = 10
var ply_maxacceleration = 1000
var ply_airspeedcap = 10
var ply_friction = 2
var ply_stopspeed = 100
var ply_gravity = 100
var ply_maxslopeangle = deg2rad(45)
var ply_maxvelocity = 35000
var ply_crouchstanceheight = 3
var ply_crouchedheight = -1
var ply_crouchlerpweight = 0.4
var ply_jumpheight = 4
var ply_stepsize = 16

# Bools
var noclip : bool
var crouching : bool
var crouched : bool
var sprinting : bool


# Floats
var sidemove : float
var upmove : float
var forwardmove : float
var ylook : float
var xlook : float
var maxspeed : float
