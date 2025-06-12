extends Node3D

var ball_scene
var ball_instance
var marker
var particles
var smoke


# Called when the node is added to the scene tree
func _ready():
	# Load (preload) the Ball scene so we can create a new instance of it
	ball_scene = preload("res://Assets/Scenes/ball.tscn")
	
	# Load (preload) the Smoke Particle scene for visual effects
	particles = preload("res://Assets/Scenes/smoke.tscn")

	# Create an instance of the Ball from the preloaded scene
	ball_instance = ball_scene.instantiate()
	
	# Create an instance of the smoke particles
	smoke = particles.instantiate()

	# Get a reference to the Marker3D node in the scene
	marker = $Marker3D

	# Set the Ball’s position to the same location as the Marker3D
	ball_instance.position = marker.position

	# Also place the smoke effect at the Marker3D position
	smoke.position = marker.position

	# Add the ball instance to the current scene as a child
	add_child(ball_instance)

	# Add the smoke effect to the current scene as a child
	add_child(smoke)

	# Start the smoke particle effect so it emits immediately
	smoke.emitting = true



func _on_cannonball_timer_timeout():
	ball_instance = ball_scene.instantiate()
	smoke = particles.instantiate()
	smoke.position = marker.position
	ball_instance.position = marker.position
	add_child(ball_instance)
	add_child(smoke)
	smoke.emitting = true
