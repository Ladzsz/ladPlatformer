extends Characters

var is_ducking = false

#overiding die from characters
func die():
	print(get_tree().get_nodes_in_group("death_screen"))
	modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.2)
	await tween.finished
	get_tree().paused = true
	get_tree().get_first_node_in_group("death_screen").visible = true

#user input
func getInput():
	
	const JUMP_VELOCITY = -400.0
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * baseSpeed.x
	
	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Flip sprite
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	# Duck input
	if Input.is_action_pressed("ui_down") and is_on_floor():
		if not is_ducking:
			is_ducking = true
			$AnimationPlayer.play("duck")
	else:
		if is_ducking:
			is_ducking = false
			$AnimationPlayer.play_backwards("duck")

	# Animations
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif is_ducking:
		$AnimatedSprite2D.play("duck")
	elif abs(velocity.x) > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
			
#players damage box
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and velocity.y <= 0:
			take_damage(100)

func _on_jump_stomp_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyHead") and velocity.y >= 0:
		area.get_parent().take_damage(100)
		velocity.y = -250

func _physics_process(delta: float) -> void:
	getInput()
	super._physics_process(delta)
	move_and_slide()
