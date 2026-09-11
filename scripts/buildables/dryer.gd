extends StaticBody2D

var build_type = "dryer"

func _ready() -> void:
	# Ensure it loads the state before deleting data
	if build_type in saved_states.building_data:
		if self.name in saved_states.building_data[build_type]:
			await load_prev_state() 
	
	# Setup the saved data for this node
	saved_states.building_data[build_type][self.name] = {}
	
	

# Saves variables to the autoload saved_states:
func save_curr_state():
	# Save the current state of a few important variables
	#saved_states.building_data[build_type][self.name]["blank"] = blank
	pass

# Loads the variable saved in the autoload saved_states:
func load_prev_state():
	# Loads the state of a few important variables
	#blank = saved_states.building_data[build_type][self.name]["blank"]
	pass


# Player interacts with the buildable
func player_interact():
	# If the player has at least one cane juice
	if globals.inventory_ingredients["wet_sugar"]["stock"] > 0:
		# Change the scene to the boiling minigame
		globals.change_scene(true, "res://scenes/minigames/dry_minigame.tscn") # TODO: add this minigame
	else:
		# Return the name of cane juice
		return globals.inventory_ingredients["wet_sugar"]["name"]

func _process(delta: float) -> void:
	pass


func _on_dryer_area_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
