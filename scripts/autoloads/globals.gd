extends Node

# Player interaction variables
var can_move = true # Interacting with the physical world
var in_cooking_menu = false
var in_menu = false
var in_inventory = false
var game_paused = false
var just_in_inventory = false
var interactable_parents = ["Farm", "Machinery", "Saucepan", "Door", "ShedDoor", "DairyDoor", "DoorToBasement", "DoorToStore", "MachineryThings", "DoorStoreOutside", "Buildables", "Clerk", "NPCs"]
var player_loading_point: String = ""
var see_text = false
var clerk_bought_from = false
# Scene *wow*
var scene = null
var fading = true
var states_setup = false

# Grid variables
var grid_size = 80

var raw_image
var texture

var noise_level = 0.0
var noise_rate = 150 # Noise_level scales at f(x)/noise_rate, 
# where f(x) is some function I haven't fully decided on yet
var min_noise_rate = 20 # noise changes by a min of time_change / min_noise_rate

# Farm variables
var dry_rate = 5 # Time it takes for a farm plot to dry
var sugar_cane_growth_min = 1 # Minimum time (in seconds) it takes to grow a single stage of sugar cane
var sugar_cane_growth_max = 2 # Maximum time (in seconds) it takes to grow a single stage of sugar cane
var sugar_cane_max_growth = 5

# Timer vaiables
var boil_time = 5
 
var money = 5000
var gelatin_cost = 5 # This will break the clerk speech when changed, but works, functionally
var gummy_worm_sell_price = 10 # Same as the above comment

# Mouse
var can_drag = true
var can_attack = true # When this is true, the mouse click will be used for attacking

var shopkeep_choice_dict = { # Shopkeep gelatin choices
	"1_text": "Buy Gelatin", 
	"2_text": "Leave", 
	"1": {
		"main_text": "How much gelatin would you like to buy? Each piece costs $" + str(gelatin_cost) + ".", 
		"1_text": "1 Gelatin", 
		"2_text": "10 Gelatin", 
		"3_text": "100 Gelatin", 
		"1": {
			"func": "buy_gelatin", 
			"arg": 1
		}, 
		"2": {
			"func": "buy_gelatin", 
			"arg": 10
		}, 
		"3": {
			"func": "buy_gelatin", 
			"arg": 100
		}
	}, 
	"2": {
		"func": "_on_exit_button_button_up"
	}
	
}

var gummy_worm_choice_dict = { # NPC gummy worm choices
	"1_text": "Sell Gummy Worms", 
	"2_text": "Leave", 
	"1": {
		"main_text": "Sure! I'll buy some gummy worms! I will buy them for $" + str(gummy_worm_sell_price) + " apiece", 
		"1_text": "Sell 1 Gummy Worm", 
		"2_text": "Sell 10 Gummy Worms", 
		"3_text": "Leave", 
		"1": {
			"func": "sell_gummy_worms", 
			"arg": 1
		}, 
		"2": {
			"func": "sell_gummy_worms", 
			"arg": 10
		}, 
		"3": {
			"func": "_on_exit_button_button_up"
		}
	}, 
	"2": {
		"func": "_on_exit_button_button_up"
	}
	
}

func _ready() -> void:
	inventory_ingredients = {
		"gummy_worm": {
			"stock": 100,
			"had_before": false,
			"name": "Gummy Worms", 
			"icon": "res://assets/items/gummy-worms.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"sugar": {
			"stock": 1,
			"had_before": false,
			"name": "Sugar", 
			"icon": "res://assets/items/sugar-spritesheet.png",
			"region": Rect2(32, 0, 32, 32)
		},
		"gelatin": {
			"stock": 1,
			"had_before": false,
			"name": "Gelatin", 
			"icon": "res://assets/items/gelitin-spritesheet.png",
			"region": Rect2(32, 0, 32, 32)
		},
		"sugar_cane": {
			"stock": 0,
			"had_before": false,
			"name": "Sugar Cane", 
			"icon": "res://assets/items/sugarcane-item.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"shredded_cane": {
			"stock": 1,
			"had_before": false,
			"name": "Shredded Cane", 
			"icon": "res://assets/items/shredded-cane.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"crushed_cane": {
			"stock": 0,
			"had_before": false,
			"name": "Crushed Cane", 
			"icon": "res://assets/items/crushed-cane.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"cane_juice": {
			"stock": 1,
			"had_before": false,
			"name": "Cane Juice", 
			"icon": "res://assets/items/liquid-spritesheet.png",
			"region": Rect2(192, 0, 32, 32)
		},
		"wet_sugar": {
			"stock": 0,
			"had_before": false,
			"name": "Wet Sugar", 
			"icon": "res://assets/items/wet-sugar-spritesheet.png",
			"region": Rect2(0, 0, 32, 32)
		},
		"cane_sugar": {
			"stock": 0,
			"had_before": false,
			"name": "Cane Sugar", 
			"icon": "res://assets/items/cane-sugar-spritesheet.png",
			"region": Rect2(32, 0, 32, 32)
		}
	}
	
	inventory_buildings = {
		# For the area, they must all end in "Area" (i.e. ConcreteArea or GrassArea)
		# This is so that I can subtract this from the area to show the user where they have to place something 
		"farm_plot": {
			"stock": 10,
			"had_before": false,
			"name": "Farm Plots", 
			"icon": "res://assets/tilemaps/buildables/sugarcane_growth_tilemap.png",
			"region": Rect2(0, 32, 32, 32), 
			"scene": load("res://scenes/buildables/farm_plot.tscn"), 
			"area": "GrassArea"
		},
		"saucepan": {
			"stock": 10,
			"had_before": true,
			"name": "Saucepans", 
			"icon": "res://assets/items/saucepan.png",
			"region": Rect2(0, 32, 32, 32), 
			"scene": load("res://scenes/buildables/saucepan.tscn"), 
			"area": "TableArea"
		},
		"shredder": {
			"stock": 1,
			"had_before": false,
			"name": "Shredder", 
			"icon": "res://assets/tilemaps/buildables/shredder_tilemap.png",
			"region": Rect2(0, 0, 32, 32), 
			"scene": load("res://scenes/buildables/shredder.tscn"), 
			"area": "TableArea"
		},
		"crusher": {
			"stock": 999,
			"had_before": false,
			"name": "Crusher", 
			"icon": "res://assets/tilemaps/buildables/hydraulic_press_spritesheet.png",
			"region": Rect2(0, 0, 32, 32), 
			"scene": load("res://scenes/buildables/crusher.tscn"), 
			"area": "TableArea"
		},
		"boiler": {
			"stock": 1,
			"had_before": false,
			"name": "Boiler", 
			"icon": "res://assets/tilemaps/buildables/boiler-tilemap.png",
			"region": Rect2(0, 0, 32, 32), 
			"scene": load("res://scenes/buildables/boiler.tscn"),
			"area": "ConcreteArea"
		},
		"centrifuge": {
			"stock": 0,
			"had_before": false,
			"name": "Centrifuge", 
			"icon": "res://assets/tilemaps/buildables/centrifuge-spritesheet.png",
			"region": Rect2(0, 0, 32, 32), 
			"area": "ConcreteArea"
		},
		"dryer": {
			"stock": 1,
			"had_before": false,
			"name": "Dryer", 
			"icon": "res://assets/tilemaps/buildables/dryer-tilemap.png",
			"region": Rect2(0, 0, 32, 32), 
			"scene": load("res://scenes/buildables/dryer.tscn"),
			"area": "ConcreteArea"
		}
	}
	
	for item in inventory_ingredients:
		inventory_ingredients[item]["icon_region"] = images(str(inventory_ingredients[item]["icon"]), inventory_ingredients[item]["region"])
	for building in inventory_buildings:
		inventory_buildings[building]["icon_region"] = images(str(inventory_buildings[building]["icon"]), inventory_buildings[building]["region"])
	
	if !states_setup:
		saved_states.setup()
		states_setup = true
	else:
		push_error("Setup stopped by states_setup var")

func _process(delta: float) -> void:
	gummy_worm_choice_dict["1"]["main_text"] = "Sure! I'll buy some gummy worms! I will buy them for $" + str(gummy_worm_sell_price) + " apiece" # Update sell price
	shopkeep_choice_dict["1"]["main_text"] = "How much gelatin would you like to buy? Each piece costs $" + str(gelatin_cost) + "." # Update buy price

func change_scene(saving = true, scene = null):
	# If saving, you need a scene
	# If loading, you don't
	if saving:
		await saved_states.save_states(get_tree().current_scene)
		
		await get_tree().process_frame
		
		call_deferred("save_scene")
		get_tree().call_deferred("change_scene_to_file", scene)
	else:
		load_scene()
		
		# Load the interactables (like FarmPlots and other machinery), along with their states
		#call_deferred("find_interactables_for_loading", get_tree().current_scene)

# Save the scene using a PackedScene
func save_scene():
	print("globals.save_scene")
	
	# Save the scene
	var scene = get_tree().current_scene
	# Init the PackedScene
	var packed_scene = PackedScene.new()
	
	make_nodes_owner(scene)
	
	# Check the scene exists
	if scene:
		# Pack the scene
		var result = packed_scene.pack(scene)
		
		# Print an error if something malfunctions
		if result == OK:
			var error = ResourceSaver.save(packed_scene, "res://scenes/saved_scene.tscn")
			if error != OK:
				push_error("An error occured while saving the scene to disk.")
			else:
				print("Saved succesfully")

# Iteratively set the owner property of all nodes as root
# This allows them to be saved to a packed scene
func make_nodes_owner(scene):
	# Iterate through all children nodes
	for child in scene.get_children():
		# If the child does not already have an owner
		# This happens for the instantiated scenes
		if child.owner == null:
			# Print things about the nodes
			#print("child: ", child)
			#print("child owner: ", child.owner)
			#print("parent: ", scene)
			#print("root: ", get_tree().current_scene)
			#print("---------------")
			
			# Update ownership
			child.owner = get_tree().current_scene
		
		# Recursively call the function 
		make_nodes_owner(child)

# Load the PackedScene
func load_scene():
	# Get the PackedScene
	var saved_scene: PackedScene = ResourceLoader.load("res://scenes/saved_scene.tscn")
	
	# Check the PackedScene exists
	if saved_scene:
		print("Loaded saved scene successfully")
		# Change the scene
		get_tree().change_scene_to_packed(saved_scene)
		
		await get_tree().process_frame
		await get_tree().process_frame
		
		# Load the states for these interactables
		#call_deferred("load_states")

# Recursively searches the scene tree to find any interactable parents
func find_interactables_for_loading(node):
	#print("Loading interactable node: ", node)
	
	#print("building data: ", saved_states.building_data)
	#print("--------------------------")
	
	if node == null:
		print("node null")
		
		await get_tree().process_frame
		find_interactables_for_loading(get_tree().current_scene)
		return
	
	for child in node.get_children():
		if child.has_method("load_prev_state"):
			child.call_deferred("load_prev_state")
		
		find_interactables_for_loading(child)



var inventory_ingredients: Dictionary

var inventory_buildings: Dictionary


func images(image: String, region):
	raw_image = load(image)
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = raw_image
	atlas_texture.region = region 
	return atlas_texture
