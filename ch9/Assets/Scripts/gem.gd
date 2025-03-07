extends Node3D




func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		body.jump_strength = 10
		body.jump_cooldown_timer.start()
		queue_free()
