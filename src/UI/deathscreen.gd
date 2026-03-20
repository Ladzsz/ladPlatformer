extends CanvasLayer

func _ready():
	Globals.checkpoint = get_tree().current_scene.scene_file_path
	add_to_group("death_screen")
	visible = false
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_respawn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(Globals.checkpoint)
