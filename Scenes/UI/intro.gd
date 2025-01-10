extends Control


# Called when the node enters the scene tree for the first time.
func load_level():
	get_tree().change_scene_to_file("res://Scenes/Level/start_area.tscn")
