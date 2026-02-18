extends Characters


func getInput():
	const JUMP_VELOCITY = -400.0
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * baseSpeed.x
	
	# Handle Jump if on floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
 		# If player is above enemy (stomping)
		if velocity.y > 0 and global_position.y < body.global_position.y:
			body.take_damage(100)  # Deal 100 damage
			velocity.y = -200  # Bounce up
		else:
			take_damage(100)  # Player takes damage from side collision	
			
func _physics_process(delta: float) -> void:
	getInput()
	super._physics_process(delta)	
	move_and_slide()
