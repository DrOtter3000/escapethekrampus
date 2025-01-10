extends Node3D

@onready var omni_light_3d: OmniLight3D = $OmniLight3D

@export var minimum_energy := .7
@export var maximum_energy := 1.4

@export var minimum_color := .55
@export var maximum_color := .7


var random_energy
var random_color


func _ready() -> void:
	get_random_energy()
	get_random_color()


func _process(delta: float) -> void:
	omni_light_3d.light_energy = lerp(omni_light_3d.light_energy, random_energy, .05)
	omni_light_3d.light_color.g = lerp(omni_light_3d.light_color.g, random_color, .05)


func get_random_energy():
	random_energy = randf_range(minimum_energy, maximum_energy)


func get_random_color():
	random_color = randf_range(minimum_color, maximum_color)


func _on_timer_timeout() -> void:
	get_random_energy()
