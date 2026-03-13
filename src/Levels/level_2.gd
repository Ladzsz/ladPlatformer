extends Node2D

@export var camera_left := 0
@export var camera_right := 720
@export var camera_top := 0
@export var camera_bottom := 2160

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var cam = player.get_node("Camera2D")
		cam.limit_left = camera_left
		cam.limit_right = camera_right
		cam.limit_top = camera_top
		cam.limit_bottom = camera_bottom
