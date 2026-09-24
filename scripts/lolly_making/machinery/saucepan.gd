extends StaticBody2D

var cooking = false

# Changed this from a global var to a local one
var readable_name = "Saucepan"

var build_type = "saucepan"

func player_interact():
	print("saucepan is cooking: ", cooking)
	if !cooking: # CHANGE SCENE DEPENDING ON STATE
		# Update this pot's value
		cooking = true
		print("Set cooking to: ", cooking)
		
		if (globals.inventory_ingredients["sugar"]["stock"] > 0 # Check you have enough ingredients
		 and globals.inventory_ingredients["gelatin"]["stock"] > 0):
			# Decrease items from inventory
			globals.inventory_ingredients["sugar"]["stock"] -= 1
			globals.inventory_ingredients["gelatin"]["stock"] -= 1
			
			# Change the scene
			globals.change_scene(true, "res://scenes/minigames/gummy_worm_minigame.tscn")
		
		else: # Return the necessary ingredients, so that the user knows what they need to get
			return globals.inventory_ingredients["sugar"]["name"] + " or " + globals.inventory_ingredients["gelatin"]["name"]
	
	else:
		# Update this pot's value
		cooking = false
		print("Set cooking to: ", cooking) 
		
		# Give the player gummy worms
		globals.inventory_ingredients["gummy_worm"]["stock"] += 4
		
		globals.change_scene(true, "res://scenes/minigames/gummy_cooking_minigame.tscn")

func _ready() -> void:
	# Ensure it loads the state before deleting data
	if build_type in saved_states.building_data:
		if self.name in saved_states.building_data[build_type]:
			#print("lading for farmplot: ", saved_states.building_data[build_type][self.name])
			await load_prev_state() 
	
	# Setup the saved data for this node
	saved_states.building_data[build_type][self.name] = {}

# Saves variables to the autoload saved_states:
func save_curr_state():
	# Save the current state of a few important variables
	saved_states.building_data[build_type][self.name]["cooking"] = cooking

# Loads the variable saved in the autoload saved_states:
func load_prev_state():
	# Loads the state of a few important variables
	cooking = saved_states.building_data[build_type][self.name]["cooking"]
