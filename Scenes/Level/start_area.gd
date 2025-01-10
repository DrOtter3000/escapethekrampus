extends Node3D

@onready var bow_1: Node3D = $ProgressionBoard/Bow1
@onready var bow_2: Node3D = $ProgressionBoard/Bow2
@onready var bow_3: Node3D = $ProgressionBoard/Bow3
@onready var bow_4: Node3D = $ProgressionBoard/Bow4
@onready var bow_5: Node3D = $ProgressionBoard/Bow5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bow_1.visible = Gamestate.level > 0
	bow_2.visible = Gamestate.level > 1
	bow_3.visible = Gamestate.level > 2
	bow_4.visible = Gamestate.level > 3
	bow_5.visible = Gamestate.level > 4
	
