extends Spatial
class_name PlayerStart

func _ready():
	var player = get_node("/root/level/player")
	player.global_transform.origin = self.global_transform.origin
	
	remove_child($model)
