extends CharacterBody2D
class_name Characters

#parent script to all characters
var baseSpeed = Vector2(300, 1000)
var enemySpeed = 100
var baseGravity = 980
var max_health: int = 100
var current_health: int

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount

	if current_health <= 0:
		die()

func die():
	queue_free()

func _physics_process(delta: float) -> void:
	velocity.y += baseGravity * delta
	
