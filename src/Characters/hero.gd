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
	
	# Handle Jump if on floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY
	elif not is_on_floor():
		$AnimatedSprite2D.play("jump")
		
	#walk animation
	if not is_ducking:
		if abs(velocity.x) > 0:
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")

	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	#duck animation
	if Input.is_action_pressed("ui_down") and is_on_floor():
		if not is_ducking:
			is_ducking = true
			$AnimatedSprite2D.play("duck")
			$AnimationPlayer.play("duck")
	else:
		if is_ducking:
			is_ducking = false
			$AnimationPlayer.play_backwards("duck")
			$AnimatedSprite2D.play("idle")
		
	
		
	
#checking if enemies colided with player body
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		#hurt enemy if above
		if global_position.y < body.global_position.y - 10 and velocity.y > -100:
			body.take_damage(100)
			velocity.y = -200
		else:
			take_damage(100)

func _physics_process(delta: float) -> void:
	getInput()
	super._physics_process(delta)
	move_and_slide()
