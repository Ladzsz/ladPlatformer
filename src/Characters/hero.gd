extends Characters

#overiding die from characters
func die():
	print("hero die")
	modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.2)
	await tween.finished
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene() 

#user input
func getInput():
	const JUMP_VELOCITY = -400.0
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * baseSpeed.x
	
	# Handle Jump if on floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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
