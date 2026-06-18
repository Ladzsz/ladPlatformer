extends "res://src/Characters/grunts.gd"

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D
const podaBullet = preload("./characterUtils/poda_seed.tscn")
var attacking = false
var can_shoot = true
var shoot_cooldown := 1.0

#shooting function
func fireshot():
	if not can_shoot:
		return

	can_shoot = false

	#spawning bullet
	var bullet = podaBullet.instantiate()
	get_tree().current_scene.add_child(bullet)

	#placxing bullet
	bullet.global_position = global_position

	#bullet direction
	var dir = sign(get_tree().get_first_node_in_group("player").global_position.x - global_position.x)
	bullet.set_direction(dir)

	# cooldown
	await get_tree().create_timer(1.0).timeout
	can_shoot = true
	
#function to detect player
func detectplayer():
	if $RayCast2D.is_colliding():
		var hit = $RayCast2D.get_collider()

		if hit.is_in_group("player"):
			fireshot()
			
#update facing
func update_facing_direction(direction: float) -> void:
	if direction == 0:
		return
		
	# Flip sprite
	animated_sprite.flip_h = direction < 0

	# Flip raycast
	ray_cast.target_position.x = abs(ray_cast.target_position.x) * sign(direction)

#movement logic
func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	# Update sprite and raycast direction based on direction
	var direction = sign(player.global_position.x - global_position.x)
	update_facing_direction(direction)
	
	# Play run and idle animations based on movement
	if direction != 0:
		animated_sprite.play("look")
	else:
		animated_sprite.play("idle")
		
	detectplayer()
	apply_gravity(delta)
	move_and_slide()
