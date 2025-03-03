extends Node2D
var health : int = 100
var jump_strength : float = 220.5
var isDashing : bool = true
var player_name : String = "Riptide"
var player_level : int = 23
var player_exp : float = 123.45
var has_key : bool = false
var spike_damage : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_health = 100
	var spike_damage = 20
	var new_health = calculate_health_after_damage(player_health, spike_damage)
	print("Player's new health:", new_health)

	
	# Example of using the function and storing the returned value
	#var remaining_health = take_spike_damage(10)  # Assume damage_amount is 10
	#print("Remaining Health: ", remaining_health)
	
	print(player_name)
	print(player_level)
	print(player_exp)
	print(has_key)
	
	#player_level = player_level + 7
	player_level += 7
	print(player_level)
	
	player_level -= 30
	print (player_level)
	
	player_level *= 2
	print (player_level)
	
	player_level /= 2
	print (player_level)
	
	
	print(health)
	health -= spike_damage
	print(health)
	
	var player_lives : int = 3
	if health == 0:
		player_lives -= 1
		
	if player_lives < 1:
		print("GAME OVER!")
		
	if player_lives <= 0:
		print("GAME OVER!")
		
	if spike_damage > health:
		print("GAME OVER!")
	
	if player_exp >= 1000:
		player_level += 1
		print("LEVEL UP")
		
	if has_key != true:
		print("DOOR LOCKED")
		
	if player_lives > 0:
		print("Keep playing!")
	elif player_lives == 0:
		print("Game Over!")
	else:
		print("Invalid number of lives!")
		
	# Check the player's health and print the appropriate message
	if health >= 80:
		print("You're in great shape!")
	elif health >= 50:
		print("You're doing okay, but be careful!")
	elif health > 0:
		print("Warning! Your health is low!")
	else:
		print("Game over! You've run out of health.")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Custom function to handle spike damage and return remaining health
func take_spike_damage(damage_amount) -> int:
	health -= damage_amount
	if health <= 0:
		print("Game Over")
		return 0  # Return 0 if health is depleted
	else:
		print("Player's current health: ", health)
		return health  # Return the remaining health
		
# Define the function to calculate the player's health after taking damage
func calculate_health_after_damage(current_health: int, damage: int) -> int:
	var new_health = current_health - damage
	return new_health






		
		
