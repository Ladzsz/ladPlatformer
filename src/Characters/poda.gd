extends "res://src/Characters/grunts.gd"

@onready var player = get_node("../../PlayerContainer/Hero")
@onready var raycast = $RayCast2D


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if player:
		
		if player.global_position.x < global_position.x:
			$AnimatedSprite2D.play("look-left")
			raycast.scale.x = 1
		else:
			$AnimatedSprite2D.play("look-right")
			raycast.scale.x = -1
			
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
		#when getting on next time ensure this  is changed to spawn the bullet.
		if collider.is_in_group("player"):
			print("Player spotted!")
			
	apply_gravity(delta)
	move_and_slide()
