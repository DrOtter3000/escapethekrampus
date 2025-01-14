extends CharacterBody3D

@onready var pause: Control = $Pause
@onready var camera_3d: Camera3D = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var lbl_action: Label = $HUD/LblAction
@onready var footstep_sfx: AudioStreamPlayer3D = $FootstepSFX
var collider
var noiseFootstep = 0.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_sensitivity_h = .1
var mouse_sensitivity_v = .1

var footstepSounds = ["res://Audio/SFX/Footsteps/footstep_concrete_land_01.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_02.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_03.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_04.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_05.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_06.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_07.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_08.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_09.wav", "res://Audio/SFX/Footsteps/footstep_concrete_land_10.wav"]
var footstepTrigger = 3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	collider = ray_cast_3d.get_collider()
	if collider != null:
		if collider.has_method("interact"):
			lbl_action.text = "(E) Leave"
			if Input.is_action_just_pressed("interact"):
				collider.interact()
		else:
			lbl_action.text = ""
	else:
		lbl_action.text = ""
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	walking_sounds()


func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity_h
		camera_3d.rotation_degrees.x -= event.relative.y * mouse_sensitivity_v
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -90, 90)


func walking_sounds():
	if (int(velocity.x) != 0) || (int(velocity.z != 0)):
		noiseFootstep += 0.1
	
	if noiseFootstep > footstepTrigger and is_on_floor():
		footstep_sfx.stream = load(footstepSounds.pick_random())
		footstep_sfx.pitch_scale = randf_range(0.8, 1.2)
		footstep_sfx.play()
		noiseFootstep = 0.0
