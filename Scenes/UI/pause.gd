extends Control

var paused = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !paused
		paused = !paused
		if paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
