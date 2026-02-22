extends "res://src/Characters/characters.gd"

@onready var ground_ray = $RayCast2D

var direction = 1
var is_dead = false

func _ready():
	max_health = 100
	current_health = 100
	
func die():
	is_dead = true
	await super.die()
	
func flip_ray():
	# Flip the RayCast's horizontal position so it stays in front of the enemy
	ground_ray.position.x = abs(ground_ray.position.x) * direction
	ground_ray.target_position.x = abs(ground_ray.target_position.x) * direction

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	# moving enemy to opposite direction if colliding with wall or edge
	if not ground_ray.is_colliding() or is_on_wall():
		direction *= -1
		flip_ray()
		
	super._physics_process(delta)
	velocity.x = direction * enemySpeed
	$AnimatedSprite2D.play("walk")
	move_and_slide()	
