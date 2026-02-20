extends Control

func _ready():
	add_to_group("death_screen")
	visible = false
	
func _on_quit_pressed() -> void:
	
	print("quit")
	get_tree().quit()


func _on_respawn_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
