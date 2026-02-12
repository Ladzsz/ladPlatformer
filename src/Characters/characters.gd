extends CharacterBody2D
class_name Characters

func _physics_process(delta: float) -> void:
	
	var baseSpeed = Vector2(300, 1000)
	var baseGravity = 980
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * baseSpeed.x
	
	velocity.y += baseGravity * delta
	
	move_and_slide()
	
