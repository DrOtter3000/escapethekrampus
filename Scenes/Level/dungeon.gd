extends Node3D


var hasAnomaly = false

@onready var xmas_tree: Node3D = $NavigationRegion3D/Living/XmasTree
@onready var lavalamp: Node3D = $NavigationRegion3D/Living/Lavalamp
@onready var food_and_drinks: Node3D = $NavigationRegion3D/Kitchen/DiningTable/FoodAndDrinks
@onready var pizza: Node3D = $NavigationRegion3D/Kitchen/DiningTable/Pizza
@onready var sled: Node3D = $NavigationRegion3D/Sleeping/Sled
@onready var crates_2: Node3D = $NavigationRegion3D/Kitchen/Crates2
@onready var fire: Node3D = $NavigationRegion3D/Living/Fireplace/SM_Prop_Fireplace_01/Fire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Gamestate.level > 0:
		initialize_level()


func level_left(choosenDoor):
	if choosenDoor == "exit" and not hasAnomaly:
		win_level()
	elif choosenDoor == "entrance" and hasAnomaly:
		win_level()
	else:
		restart_level()
	
	
func restart_level():
	Gamestate.level = 0
	get_tree().change_scene_to_file("res://Scenes/Level/start_area.tscn")


func win_level():
	Gamestate.level += 1
	if Gamestate.level == 5:
		print("Anomaly " + str(Gamestate.level))
	if Gamestate.level < 6:
		get_tree().change_scene_to_file("res://Scenes/Level/start_area.tscn")
	else:
		win_game()


func initialize_level():
	randomize()
	var anomaly_selector = randi_range(0, 1)
	if anomaly_selector == 0:
		choose_anomaly()
		hasAnomaly = true


func choose_anomaly():
	var anomaly_id = randi_range(1, 19) 
	match anomaly_id:
		1: 
			sled.queue_free()
		2:
			food_and_drinks.visible = false
			pizza.visible = true
		3:
			crates_2.queue_free()
		4:
			xmas_tree.visible = false
			lavalamp.visible = true
		5:
			fire.queue_free()
		6:
			%BeerBarrel.queue_free()
		7:
			%Scepter.queue_free()
		8:
			%Cauldron.queue_free()
		9: 
			%ToyTrain.queue_free()
		10:
			%WoodStackKitchen.queue_free()
		11:
			%BottleAndGlass.queue_free()
		12:
			%BottleAndGlass.visible = false
			%AlternativeBottleAndGlass.visible = true
		13:
			%PotatoBoxPantry.visible = false
			%CarrotBoxPantry.visible = true
		14:
			xmas_tree.visible = false
			%XmasTree_02.visible = true
		15:
			%DresserBookPile.visible = false
			%DresserBook.visible = true
		16:
			%Bottles1.visible = false
			%Bottles2.visible = false
		17:
			%Chalice.queue_free()
		18:
			%Skull.visible = true
		19:
			%CookingPot.queue_free()
		20:
			%IronMaidenDoor_L.rotation.y = 65
			%IronMaidenDoor_R.rotation.y = -65


func win_game():
	get_tree().change_scene_to_file("res://Scenes/UI/winning_screen.tscn")
