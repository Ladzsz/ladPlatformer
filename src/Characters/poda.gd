extends "res://src/Characters/grunts.gd"

@onready var player = get_node("../../PlayerContainer/Hero")
@onready var raycast = $RayCast2D

const poda_Bullet_Scene = preload("./characterUtils/poda_seed.tscn")
var can_shoot = true

func shoot():
	#checking shot
	if not can_shoot:
		return
		
	can_shoot = false
		
	#create an instance
	var podaBullet = poda_Bullet_Scene.instantiate()
	
	# Position and Add
	podaBullet.global_position = self.global_position
	
	# Add to the root  
	get_tree().root.add_child(podaBullet)
	
	#timer for shots
	await get_tree().create_timer(0.50).timeout
	can_shoot = true

func _physics_process(delta: float) -> void:
	if is_dead:
		return

#direction control
	if player:
		
		if player.global_position.x < global_position.x:
			$AnimatedSprite2D.play("look-left")
			raycast.scale.x = 1
		else:
			$AnimatedSprite2D.play("look-right")
			raycast.scale.x = -1
			
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
		#shoot when player collides
		if collider.is_in_group("player"):
			shoot()
			
	apply_gravity(delta)
	move_and_slide()
