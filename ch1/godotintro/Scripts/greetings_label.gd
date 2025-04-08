extends Label

var xVelocity = 150 #150 pixels per second to the right
var yVelocity = 120 #120 pixels per second downwards
var velocity = Vector2(xVelocity, yVelocity)  # Initial speed and direction
var screen_size_x  #screen horizontal dimension
var screen_size_y  #screen vertical dimension
var label_size_x   #label width
var label_size_y   #label height

func _ready():
	text = "Go Go Godot!"
	# Get the screen size (viewport size)
	screen_size_x = get_viewport_rect().size.x
	screen_size_y = get_viewport_rect().size.y
	label_size_x = size.x
	label_size_y = size.y

func _process(delta):
	position = position + velocity * delta

	# Bounce off left/right edges
	if position.x < 0 or position.x + label_size_x > screen_size_x:
		velocity.x *= -1
		position.x = clamp(position.x, 0, screen_size_x - label_size_x)

	# Bounce off top/bottom edges
	if position.y < 0 or position.y + label_size_y > screen_size_y:
		velocity.y *= -1
		position.y = clamp(position.y, 0, screen_size_y - label_size_y)
