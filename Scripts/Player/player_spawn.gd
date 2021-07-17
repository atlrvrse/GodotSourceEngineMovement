extends Spatial

var player = preload("res://Scripts/Player/player.tscn")
var playerscript = load("res://Scripts/Player/player_movement.gd")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _init():
	player = player.instance()
	add_child(player)
	playerscript.new()
	player.set_script(playerscript)
