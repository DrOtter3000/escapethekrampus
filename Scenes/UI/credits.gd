extends Control


# Called when the node enters the scene tree for the first time.
func change_scene():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
