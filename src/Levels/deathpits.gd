extends Area2D

#kill anything that falls in pit
func _on_body_entered(body):
	if body.is_in_group("pitDeath"):
		body.take_damage(300)
