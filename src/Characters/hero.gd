extends "res://src/Characters/characters.gd"


func _physics_process(delta: float) -> void:
	const JUMP_VELOCITY = -400.0
	
	# Handle Jump if on floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	super._physics_process(delta)	
