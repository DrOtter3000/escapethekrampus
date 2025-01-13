extends CharacterBody3D


var target_position = Vector3.ZERO
var list_of_target_positions = []
var haunting = false

@onready var ray_cast_3d: RayCast3D = $KrampusLP/Detectors/RayCast3D
@onready var ray_cast_3d_2: RayCast3D = $KrampusLP/Detectors/RayCast3D2
@onready var ray_cast_3d_3: RayCast3D = $KrampusLP/Detectors/RayCast3D3
@onready var catch_ray_cast: RayCast3D = $KrampusLP/CatchRayCast
@onready var voice_player: AudioStreamPlayer3D = $VoicePlayer

var normal_voice_lines = ["res://Audio/Voices/Krampus/Normal/Normal1.wav", "res://Audio/Voices/Krampus/Normal/Normal2.wav", "res://Audio/Voices/Krampus/Normal/Normal3.wav", "res://Audio/Voices/Krampus/Normal/Normal4.wav", "res://Audio/Voices/Krampus/Normal/Normal5.wav", "res://Audio/Voices/Krampus/Normal/Normal6.wav", "res://Audio/Voices/Krampus/Normal/Normal7.wav", "res://Audio/Voices/Krampus/Normal/Normal8.wav", "res://Audio/Voices/Krampus/Normal/Normal9.wav", "res://Audio/Voices/Krampus/Normal/Normal10.wav", "res://Audio/Voices/Krampus/Normal/Normal11.wav", "res://Audio/Voices/Krampus/Normal/Normal12.wav"]
var angry_voice_lines = ["res://Audio/Voices/Krampus/Angry/Angry2.wav", "res://Audio/Voices/Krampus/Angry/Angry3.wav", "res://Audio/Voices/Krampus/Angry/Angry4.wav", "res://Audio/Voices/Krampus/Angry/Angry5.wav", "res://Audio/Voices/Krampus/Angry/Angry6.wav", "res://Audio/Voices/Krampus/Angry/Angry7.wav", "res://Audio/Voices/Krampus/Angry/Angry8.wav", "res://Audio/Voices/Krampus/Angry/Angry9.wav", "res://Audio/Voices/Krampus/Angry/Angry.wav"]

@export var speed = 1

@onready var nav: NavigationAgent3D = $NavigationAgent3D

var player
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	player = get_tree().get_first_node_in_group("Player")
	list_of_target_positions = get_node("../TargetPositions").get_children()
	set_new_target_position()
	play_voice()


func _process(delta):
	var player_position = get_tree().get_first_node_in_group("Player").global_position
	var direction = Vector3()
	var total_speed = speed
	
	if catch_ray_cast.get_collider() != null:
		if catch_ray_cast.get_collider().is_in_group("Player"):
			get_tree().change_scene_to_file("res://Scenes/Level/jumpscare.tscn")
	
	if not haunting and ray_cast_3d.get_collider() != null:
		if ray_cast_3d.get_collider().is_in_group("Player"):
			activate_haunting()
	
	if not haunting and ray_cast_3d_2.get_collider() != null:
		if ray_cast_3d_2.get_collider().is_in_group("Player"):
			activate_haunting()
	
	if not haunting and ray_cast_3d_3.get_collider() != null:
		if ray_cast_3d_3.get_collider().is_in_group("Player"):
			activate_haunting()
	
	nav.target_position = target_position.global_position
	
	direction = nav.get_next_path_position() - global_position
	direction.y = 0
	direction = direction.normalized()
	
	velocity = direction * total_speed
	velocity.y -= gravity * delta
	
	if !haunting:
		var look_direction = -Vector2(velocity.z, velocity.x)
		rotation.y = look_direction.angle()
	else:
		look_at(Vector3(player_position.x, 0, player_position.z))
		#look_at(get_tree().get_first_node_in_group("Player").global_position)
	
	if nav.is_navigation_finished():
		set_new_target_position()

	velocity.y -= gravity * delta
	
	move_and_slide()
	


func set_new_target_position():
	randomize()
	target_position = list_of_target_positions.pick_random()


func activate_haunting():
	haunting = true
	target_position = player
	speed = 3
	play_voice()


func play_voice():
	if !haunting:
		voice_player.stream = load(normal_voice_lines.pick_random())
	else:
		voice_player.stream = load(angry_voice_lines.pick_random())
	
	voice_player.play()
	
	await voice_player.finished
	
	await get_tree().create_timer(randi_range(5, 8)).timeout
	
	play_voice()
