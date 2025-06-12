extends CharacterBody3D

@export var speed = 3

func _process(delta):
	position.z -= speed * delta
	
	


func _on_destroy_timer_timeout():
	queue_free()
