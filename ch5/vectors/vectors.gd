extends Sprite2D

var movement_vector = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += movement_vector
	
	#Access the individual x and y components of the position
	var x_position = position.x
	var y_position = position.y
	
	#Display the x and y components in the output console
	
	print("Sprite Position - X: ", x_position, " Y: ", y_position)
	
	#store the x and y positions of the edges of the screen
	var horizontal_edge = get_viewport_rect().size.x
	var vertical_edge = get_viewport_rect().size.y
	
	#Check for screen boundaries to reverse direction
	if x_position < 0 or x_position > horizontal_edge:
		#reverse the x direction
		movement_vector.x *= -1
	if y_position < 0 or y_position > vertical_edge:
		#Reverse the y direction
		movement_vector.y *= -1
		
