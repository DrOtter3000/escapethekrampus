extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_btn_play_pressed() -> void:
	Gamestate.level = 0
	get_tree().change_scene_to_file("res://Scenes/UI/intro.tscn")


func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _on_btn_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/credits.tscn")


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
