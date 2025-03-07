extends Node3D

var time: float
@onready var static_body_3d = $StaticBody3D

func _process(delta):
	time += delta
	static_body_3d.position = Vector3(get_sine(),get_sine(),get_sine())
	
	
func get_sine():
	return sin(time * 0.5) * 0.5
	
