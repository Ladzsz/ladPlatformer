extends Area2D

#kill anything that falls in pit
func _on_body_entered(body):
	print("Body entered pit: ", body.name, " | Groups: ", body.get_groups())
	if body.is_in_group("pitDeath"):
		body.take_damage(300)
