extends GridContainer

var ui_showfps = 0
var fps = Engine.get_frames_per_second()


func _process(delta):
	
	if ui_showfps == 1:
		var fps: float = Engine.get_frames_per_second()
		
		$fps.text = "fps: "
		$fps.text += str(fps)
	else:
		self.visible = false
