extends Node2D
var health : int = 100
var jump_strength : float = 220.5
var is_dashing : bool = true

#Called when the node enters the scene tree for the first time.
func _ready():
	print(health)
