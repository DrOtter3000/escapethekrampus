extends Control

var level_just_started := true
var skip_intro := .00


func _ready() -> void:
	%SkipContainer.visible = true


func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_accept"):
		%SkipContainer.visible = true
		$SkipContainer/VBoxContainer/ProgressBar.visible = true
		$SkipContainer/VBoxContainer/ProgressBar.value = skip_intro
		skip_intro += delta
		
	else:
		$SkipContainer/VBoxContainer/ProgressBar.visible = false
		if !level_just_started:
			%SkipContainer.visible = false
		skip_intro = 0.0
	
	if skip_intro > 1:
		load_level()


func load_level():
	get_tree().change_scene_to_file("res://Scenes/Level/start_area.tscn")


func hide_skip_container():
	level_just_started = false
	if not Input.is_action_pressed("ui_accept"):
		%SkipContainer.visible = false
