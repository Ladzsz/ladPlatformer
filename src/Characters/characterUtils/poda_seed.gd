extends Area2D

@onready var player = get_node("../../PlayerContainer/Hero")
@export var speed: float = 500.0
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	var movement = transform.x * speed * delta
	global_position += movement

	if player:
		if player.global_position.x < global_position.x:
			$AnimatedSprite2D.play("left")
		else:
			$AnimatedSprite2D.play("right")


# despawn bullet when off screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


# bullet damage player
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(100)
