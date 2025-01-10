extends StaticBody3D
class_name Door

@export var outside = true
@export var exit = false


func interact():
	if outside:
		get_tree().change_scene_to_file("res://Scenes/Level/dungeon.tscn")
	else:
		if exit:
			get_tree().call_group("Dungeon", "level_left", "exit")
		else:
			get_tree().call_group("Dungeon", "level_left", "entrance")
