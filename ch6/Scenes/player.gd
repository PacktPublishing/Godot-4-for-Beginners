extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	move_and_slide()
	
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
func handle_movement(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
