extends CharacterBody3D

signal gem_collected

@export_subgroup("Components")
@export var view: Node3D
@export_subgroup("Properties")
@export var movement_speed = 250
@export var jump_strength = 7

@onready var model = $MeshInstance3D


var movement_velocity: Vector3
var rotation_direction: float
var gravity = 0
var previously_floored = false
var jump_single = true
var jump_double = true
var gems = 0


func _physics_process(delta):
	#Call functions
	handle_controls(delta)
	handle_gravity(delta)
	handle_movement(delta)
	handle_rotation(delta)
	handle_respawn(delta)
	

func handle_gravity(delta):
	gravity += 25 * delta
	if gravity > 0 and is_on_floor():
		jump_single = true
		gravity = 0


func jump():
	gravity -= jump_strength
	model.scale = Vector3(0.5,1.5,0.5)
	if jump_single:
		jump_single = false
		jump_double = true
	else:
		jump_double = false
		
		
func handle_controls(delta):
	#Movement
	var input = Vector3.ZERO
	
	input.x = Input.get_axis("left","right")
	input.z = Input.get_axis("up","down")
	
	input = input.rotated(Vector3.UP, view.rotation.z)
	
	if input.length() > 1:
		input = input.normalized()
		
	movement_velocity = input * movement_speed * delta
	
	#Jumping
	if Input.is_action_just_pressed("jump"):
		if jump_single or jump_double:
			jump()


func collect_gems():
	gems += 1
	gem_collected.emit(gems)
	

func handle_movement(delta):
	var applied_velocity: Vector3
	
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()
	
	
func handle_rotation(delta):
	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()
		
	rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)	
	
	
func handle_respawn(delta):
	if position.y < -10:
		get_tree().reload_current_scene()
		
	#Animation for scale (jumping and landing)
	model.scale = model.scale.lerp(Vector3(1,1,1), delta * 10)
	
	#Animation when landing
	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25,0.75,1.25)
		
	previously_floored = is_on_floor()
