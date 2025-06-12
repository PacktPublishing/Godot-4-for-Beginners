extends Node3D




func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		body.on_gem_collected()
		queue_free()
