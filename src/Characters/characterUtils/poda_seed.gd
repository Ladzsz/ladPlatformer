extends Area2D
@onready var player = get_tree().get_first_node_in_group("player")
@export var speed: float = 500.0
var direction := 1

# direciton control
func _ready() -> void:
	if player.global_position.x < global_position.x:
		direction = -1
		$AnimatedSprite2D.flip_h=direction <0
	else:
		direction = 1

# speed

func _process(delta: float) -> void:
	global_position.x += direction * speed * delta
	
# despawn bullet when off screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
# bullet damage player
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(100)
		queue_free()
