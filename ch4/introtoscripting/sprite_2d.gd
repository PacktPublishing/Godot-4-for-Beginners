extends Sprite2D

var speed = 100
var velocity = Vector2.ZERO

func _ready():
	print("Sprite is ready to move!")

func _process(delta):
	# Check input and set direction
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

func _physics_process(delta):
	# Move the sprite using physics
	position += velocity * speed * delta
