extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$GreetingsLabel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event is InputEventMouseButton:
		$GreetingsLabel.show()
		if event.button_index == MOUSE_BUTTON_LEFT:
			$GreetingsLabel.text = "Hi Folks!"
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			$GreetingsLabel.text = "Godot is Great!"
	
	elif event is InputEventKey:
		$GreetingsLabel.show()
		
		if event.keycode == KEY_ENTER:
			$GreetingsLabel.text = "Hello World!"
		
