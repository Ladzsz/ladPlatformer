extends Node


func _ready():
	$Hero.died.connect(_on_player_died)

func _on_player_died():
	print($DeathScreen)
	$DeathScreen.visible = true  
	get_tree().paused = true
