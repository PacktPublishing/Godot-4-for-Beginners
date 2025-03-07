extends Node3D

var scene
var ball
var marker
var particles
var smoke


func _ready():
	scene = preload("res://Assets/Scenes/ball.tscn")
	particles = preload("res://Assets/Scenes/smoke.tscn")
	ball = scene.instantiate()
	smoke = particles.instantiate()
	marker = $Marker3D
	ball.position = marker.position
	smoke.position = marker.position
	add_child(ball)
	add_child(smoke)
	smoke.emitting = true


func _on_cannonball_timer_timeout():
	ball = scene.instantiate()
	smoke = particles.instantiate()
	smoke.position = marker.position
	ball.position = marker.position
	add_child(ball)
	add_child(smoke)
	smoke.emitting = true
