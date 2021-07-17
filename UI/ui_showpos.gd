extends GridContainer

var ui_showpos = 0
onready var player = get_parent()
onready var view = get_node("../view")
"""
func _process(delta):
	
	var pos = player.global_transform.origin
	var ang_trans = view.get_translation()
	var ang_rot = view.get_rotation()
	var vel = player.vel.length()
	var is_on_floor = player.is_on_floor()
	
	match ui_showpos:
		
		0:
			self.visible = false
		
		1:
			self.visible = true
			
			$pos.text = "pos:   "
			$pos.text += str(pos)
			
			$ang.text = "ang:   "
			$ang.text += str(ang_trans + ang_rot)
			
			$vel.text = "vel:   "
			$vel.text += str(vel)
			
			$is_on_floor.set_text("is_on_floor:   " + str(is_on_floor))
"""
