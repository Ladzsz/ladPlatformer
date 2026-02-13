extends "res://src/Characters/characters.gd"

@onready var ground_ray = $RayCast2D

var direction = 1

func _ready():
	max_health = 100
	current_health = 100
	
func flip_ray():
	# Flip the RayCast's horizontal position so it stays in front of the enemy
	ground_ray.position.x = abs(ground_ray.position.x) * direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Change direction if fall off ledge
	if not ground_ray.is_colliding():
		direction *= -1 
		flip_ray() 
		
	#change direction if hit a wall	
	if is_on_wall():
		direction *- -1		
		
	velocity.x = direction * enemySpeed
		
	move_and_slide()	
