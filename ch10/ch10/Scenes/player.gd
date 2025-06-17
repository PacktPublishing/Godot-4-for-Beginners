extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var jump = $Jump
@onready var collect = $Collect

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FRICTION = 100

var jump_count = 0
var is_wall_sliding = false
var strawberry_count = 0
var level_strawberries
var hearts = 3
var isHit = false


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	double_jump()
	wall_slide(delta)
	animate()
	check_pass_through()
	move_and_slide()
	complete_level()
	#print("level strawberries: "+str(level_strawberries)+" strawberry count: "+str(strawberry_count))
	

func hurt():
	isHit = true
	hearts -= 1
	if hearts <= 0:
		death()
		
		
func death():
	velocity.y = -600
	set_collision_mask_value(2,false)
	set_collision_mask_value(3, false)


func get_hearts():
	return hearts


func complete_level():
	if  strawberry_count == level_strawberries:
		var checkpoint = get_tree().get_first_node_in_group("checkpoint")
		checkpoint.emit_signal("trigger")
		strawberry_count = 0
	
	
	
func add_score(amount):
	collect.play()
	strawberry_count += amount
	

func animate():
	if isHit:
		animations.play("hit")
		await animations.animation_finished
		animations.play("idle")  # Optional: transition back to idle
		return  # Prevent further animation changes this frame

	if hearts == 0:
		return  # Dead, don't animate further

	# Stationary player
	if velocity.x == 0 and velocity.y == 0:
		animations.play("idle")

	# Player moving right
	elif velocity.x >= 0 and velocity.y == 0:
		animations.play("run")
		animations.flip_h = false

	# Player moving left
	elif velocity.x <= 0 and velocity.y == 0:
		animations.play("run")
		animations.flip_h = true

	# Player is falling
	elif velocity.y > 0 and !is_wall_sliding:
		animations.play("fall")

	# Player is jumping (initial jump)
	elif velocity.y < 0 and jump_count == 0:
		animations.play("jump")

	# Player is double-jumping
	elif !is_on_floor() and jump_count > 0 and !is_wall_sliding:
		animations.play("double_jump")

	# Player is wall sliding on the right
	elif is_wall_sliding and Input.is_action_pressed("ui_right"):
		animations.flip_h = false
		animations.play("wall_slide")

	# Player is wall sliding on the left
	elif is_wall_sliding and Input.is_action_pressed("ui_left"):
		animations.flip_h = true
		animations.play("wall_slide")

	
	
func check_pass_through():
	if Input.is_action_pressed("ui_down"):
		set_collision_mask_value(3,false)
	else:
		set_collision_mask_value(3,true)
	
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump.play()
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	if is_on_floor():
		jump_count = 0
		
		
func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false  # Ensure wall slide stops when leaving the wall

	if is_wall_sliding:
		velocity.y = min(velocity.y, FRICTION)
		

func double_jump():
	#Handle double jump
	if Input.is_action_just_pressed("ui_accept") and !is_on_floor() and jump_count < 1:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
func handle_movement(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
