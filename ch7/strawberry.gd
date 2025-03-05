extends Area2D

func _process(delta):
	$AnimatedSprite2D.play("idle")
	


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(1)
		queue_free() # remove strawberry
