extends Node

# Player interaction variables
var can_move = true # Interacting with the physica world
var in_cooking_menu = false
var in_menu = false
var in_inventory = false
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

var inventory_ingredients: Dictionary = {
	"gummy_worm": {
		"stock": 0,
		"had_before": false,
		"name": "Gummy Worms", 
		"icon": load()
	},
	"sugar": {
		"stock": 0,
		"had_before": false,
		"name": "Sugar", 
		"icon": load()
	},
	"gelatin": {
		"stock": 0,
		"had_before": false,
		"name": "Gelatin", 
		"icon": load()
	},
	"sugar_cane": {
		"stock": 0,
		"had_before": false,
		"name": "Sugar Cane", 
		"icon": load()
	},
	"shredded_cane": {
		"stock": 0,
		"had_before": false,
		"name": "Shredded Cane", 
		"icon": load()
	},
	"crushed_cane": {
		"stock": 0,
		"had_before": false,
		"name": "Crushed Cane", 
		"icon": load()
	},
	"cane_juice": {
		"stock": 0,
		"had_before": false,
		"name": "Cane Juice", 
		"icon": load()
	},
	"cane_sugar": {
		"stock": 0,
		"had_before": false,
		"name": "Cane Juice", 
		"icon": load()
	},
	"pure_sugar": {
		"stock": 0,
		"had_before": false,
		"name": "Pure Sugar", 
		"icon": load()
	}
}

var inventory_buildings: Dictionary = {
	"farm_plot": {
		"stock": 0,
		"had_before": false,
		"name": "Farm Plots", 
		"icon": load()
	},
	"saucepan": {
		"stock": 1,
		"had_before": true,
		"name": "Saucepans", 
		"icon": load()
	},
	"shredder": {
		"stock": 0,
		"had_before": false,
		"name": "Shredder", 
		"icon": load()
	},
	"crusher": {
		"stock": 0,
		"had_before": false,
		"name": "Crusher", 
		"icon": load()
	},
	"boiler": {
		"stock": 0,
		"had_before": false,
		"name": "Boiler", 
		"icon": load()
	},
	"centrifuge": {
		"stock": 0,
		"had_before": false,
		"name": "Centrifuge", 
		"icon": load()
	}
}
