extends Area2D

#grabbing next level
@export var next_level: String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Something entered:", body)
		Gamedata.checkpoint = next_level
		get_tree().change_scene_to_file(next_level)
