extends Area2D

signal trigger

var level_complete = false

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("flag_fly")
	level_complete = true
	
func _on_trigger():
	$AnimatedSprite2D.play("trigger")
	
	
func _on_body_entered(body):
	if level_complete:
		$Confetti_Cannon.fire()
		
		
