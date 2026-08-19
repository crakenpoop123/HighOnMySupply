extends Node

# Player interaction variables
var can_move = true # Interacting with the physica world
var in_cooking_menu = false
var in_menu = false
var in_inventory = false
var just_in_inventory = false
var interactable_parents = ["Farm", "Machinery", "Saucepan", "Door", "ShedDoor", "DairyDoor"]

# Inventory variables
var gummy_worm_stock: int = 0
var sugar = 0
var gelatin = 0
var money = 10
# Sugar variables
var sugar_cane = 0
var shredded_cane = 0
var crushed_cane = 0
var cane_juice = 0
var cane_sugar = 0
var pure_sugar = 0

var raw_image
var texture

# Farm variables
var dry_rate = 5 # Time it takes for a farm plot to dry
var sugar_cane_growth_min = 1 # Minimum time (in seconds) it takes to grow a single stage of sugar cane
var sugar_cane_growth_max = 2 # Maximum time (in seconds) it takes to grow a single stage of sugar cane
var sugar_cane_max_growth = 5

#mouse
var can_drag = true
var can_attack = true # When this is true, the mouse click will be used for attacking

#Basement
var saucepan_on_table = true

func _ready() -> void:
	inventory_ingredients = {
		"gummy_worm": {
			"stock": 0,
			"had_before": false,
			"name": "Gummy Worms", 
			"icon": "res://assets/gummy-worms.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"sugar": {
			"stock": 0,
			"had_before": false,
			"name": "Sugar", 
			"icon": "res://assets/tilemaps/sugar-spritesheet.png",
			"region": Rect2(32, 0, 32, 32)
		},
		"gelatin": {
			"stock": 0,
			"had_before": false,
			"name": "Gelatin", 
			"icon": "res://assets/tilemaps/gelitin-spritesheet.png",
			"region": Rect2(32, 0, 32, 32)
		},
		"sugar_cane": {
			"stock": 0,
			"had_before": false,
			"name": "Sugar Cane", 
			"icon": "res://assets/sugarcane-item.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"shredded_cane": {
			"stock": 0,
			"had_before": false,
			"name": "Shredded Cane", 
			"icon": "res://assets/misc/eye.jpg",
			"region": Rect2(0, 0, 32, 32)
		},
		"crushed_cane": {
			"stock": 0,
			"had_before": false,
			"name": "Crushed Cane", 
			"icon": "res://assets/misc/eye.jpg",
			"region": Rect2(0, 0, 32, 32)
		},
		"cane_juice": {
			"stock": 0,
			"had_before": false,
			"name": "Cane Juice", 
			"icon": "res://assets/misc/eye.jpg",
			"region": Rect2(0, 0, 32, 32)
		},
		"cane_sugar": {
			"stock": 0,
			"had_before": false,
			"name": "Cane Sugar", 
			"icon": "res://assets/misc/eye.jpg",
			"region": Rect2(0, 0, 32, 32)
		},
		"pure_sugar": {
			"stock": 0,
			"had_before": false,
			"name": "Pure Sugar", 
			"icon": "res://assets/misc/eye.jpg",
			"region": Rect2(0, 0, 32, 32)
		}
	}
	
	inventory_buildings = {
		"farm_plot": {
			"stock": 0,
			"had_before": false,
			"name": "Farm Plots", 
			"icon": "res://assets/tilemaps/sugarcane_growth_tilemap.png",
			"region": Rect2(0, 32, 32, 32)
		},
		"saucepan": {
			"stock": 1,
			"had_before": true,
			"name": "Saucepans", 
			"icon": "res://assets/misc/saucepan.png",
			"region": Rect2(0, 32, 32, 32)
		},
		"shredder": {
			"stock": 0,
			"had_before": false,
			"name": "Shredder", 
			"icon": "res://assets/tilemaps/shredder_tilemap.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"crusher": {
			"stock": 0,
			"had_before": false,
			"name": "Crusher", 
			"icon": "res://assets/tilemaps/hydraulic_press_spritesheet.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"boiler": {
			"stock": 0,
			"had_before": false,
			"name": "Boiler", 
			"icon": "res://assets/tilemaps/boiler-tilemap.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"centrifuge": {
			"stock": 0,
			"had_before": false,
			"name": "Centrifuge", 
			"icon": "res://assets/tilemaps/centrifuge-spritesheet.png",
			"region": Rect2(0, 0, 32, 32)
		}
	}
	
	for item in inventory_ingredients:
		inventory_ingredients[item]["icon_region"] = images(str(inventory_ingredients[item]["icon"]), inventory_ingredients[item]["region"])
	for building in inventory_buildings:
		inventory_buildings[building]["icon_region"] = images(str(inventory_buildings[building]["icon"]), inventory_buildings[building]["region"])
		

func change_scene(saving = true, scene = null):
	# If saving, you need a scene
	# If loading, you don't
	if saving:
		save_scene()
		get_tree().change_scene_to_file(scene)
	else:
		load_scene()

# Save the scene using a PackedScene
func save_scene():
	# Save the scene
	var scene = get_tree().current_scene
	# Init the PackedScene
	var packed_scene = PackedScene.new()
	
	# Check the scene exists
	if scene:
		# Pack the scene
		var result = packed_scene.pack(scene)
		
		# Print an error if something malfunctions
		if result == OK:
			var error = ResourceSaver.save(packed_scene, "res://scenes//saved_scene.tscn")
			if error != OK:
				push_error("An error occured while saving the scene to disk.")

# Load the PackedScene
func load_scene():
	# Get the PackedScene
	var saved_scene: PackedScene = ResourceLoader.load("res://scenes/saved_scene.tscn")
	
	# Check the PackedScene exists
	if saved_scene:
		# Change the scene
		get_tree().change_scene_to_packed.call_deferred(saved_scene)

var inventory_ingredients: Dictionary

var inventory_buildings: Dictionary


func images(image: String, region):
	raw_image = load(image)
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = raw_image
	atlas_texture.region = region 
	return atlas_texture
