extends Node2D

@onready var update_health_hud = $HUD
@onready var player = $Player
@onready var strawberries = $Collectibles

func _ready():
	player.level_strawberries = strawberries.get_child_count()
	
	
func _process(delta):
	update_health_hud.frame = player.get_hearts()
