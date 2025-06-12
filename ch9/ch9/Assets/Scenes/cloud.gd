extends Node3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

var time: float

func _process(delta):
	time += delta
	mesh_instance_3d.position = Vector3(get_sine(),get_sine(),get_sine())
	
	
func get_sine():
	return sin(time * 0.5) * 0.5
	
