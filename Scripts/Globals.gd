extends Node

# Player interaction variables
var can_move = true # Interacting with the physica world
var in_cooking_menu = false
var in_menu = false
var in_inventory = false

# Lolly production variables
var gummy_worm_stock: int = 0
var sugar = 0
var gelatin = 0
var money = 10

# Farm variables
var farm_exists = false
var dry_rate = 5 # Time it takes for a farm plot to dry
var sugar_cane_growth_min = 1 # Minimum time (in seconds) it takes to grow a single stage of sugar cane
var sugar_cane_growth_max = 2 # Maximum time (in seconds) it takes to grow a single stage of sugar cane
var sugar_cane_max_growth = 7





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
			var error = ResourceSaver.save(packed_scene, "res://Scenes//saved_tutorial.tscn")
			if error != OK:
				push_error("An error occured while saving the scene to disk.")

# Load the PackedScene
func load_scene():
	# Get the PackedScene
	var saved_scene: PackedScene = ResourceLoader.load("res://Scenes/saved_tutorial.tscn")
	
	# Check the PackedScene exists
	if saved_scene:
		# Change the scene
		get_tree().change_scene_to_packed.call_deferred(saved_scene)
