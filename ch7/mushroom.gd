extends CharacterBody2D

const SPEED = 75

var direction = 1
var health = 1

func _physics_process(delta):
	add_gravity(delta)
	update_driection()
	move_and_slide()
	reverse_direction()
	platform_edge()
	mushroom_death()


func add_gravity(delta):
	#Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta


func update_driection():
	#move enemy at constant speed
	velocity.x = SPEED * direction


func reverse_direction():
	#Reverse direction when hitting a wall
	if is_on_wall():
		direction = -direction
		

func platform_edge():
	if not $RayCast2D.is_colliding():
		direction = -direction
		$RayCast2D.position.x *= -1


func _on_death_zone_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = -500
		health -= 1


func _on_hurt_player_zone_body_entered(body):
	if "Player" in body.name:
		body.hurt()
		
		
func mushroom_death():
	if health <= 0:
		$CollisionShape2D.disabled = true
		$HurtPlayerZone.monitoring = false
		$AnimatedSprite2D2.play("death")


func _on_animated_sprite_2d_2_animation_finished():
	if $AnimatedSprite2D2.animation == "death":
		queue_free()
