extends StaticBody2D

var build_type = "boiler"

var boiler_state = "empty"

func _ready() -> void:
	# Ensure it loads the state before deleting data
	if build_type in saved_states.building_data:
		if self.name in saved_states.building_data[build_type]:
			load_prev_state() 
	
	# Setup the saved data for this node
	saved_states.building_data[build_type][self.name] = {}
	
	save_curr_state()

# Saves variables to the autoload saved_states:
func save_curr_state():
	# Save the current state of a few important variables
	saved_states.building_data[build_type][self.name]["state"] = boiler_state

# Loads the variable saved in the autoload saved_states:
func load_prev_state():
	# Loads the state of a few important variables
	boiler_state = saved_states.building_data[build_type][self.name]["state"]


# Player interacts with the buildable
func player_interact():
	if boiler_state == "empty":
		# If the player has at least one cane juice
		if globals.inventory_ingredients["cane_juice"]["stock"] > 0:
			# Decrease the stock of cane juice
			globals.inventory_ingredients["cane_juice"]["stock"] -= 1
			
			# Change the state to dirty
			boiler_state = "dirty"
			
			# Save the current state
			save_curr_state()
			
			# Change the scene to the boiling minigame
			globals.change_scene(true, "res://scenes/minigames/boil_minigame.tscn")
		else:
			# Return the name of cane juice
			return globals.inventory_ingredients["cane_juice"]["name"]
	elif boiler_state == "done":
		# Empty the boiler
		boiler_state = "empty"
		
		globals.inventory_ingredients["wet_sugar"]["stock"] += 1

func _process(delta: float) -> void:
	if boiler_state == "empty":
		# Hide the liquid
		$LiquidInBoiler.visible = false
		# Hide the flame
		$BoilerSprite.frame = 0
	elif boiler_state == "dirty":
		# Show a green liquid in the boiler 
		$LiquidInBoiler.visible = true
		$LiquidInBoiler.region_rect = Rect2(206, 10, 5.177, 18.574) # This is zoomed in on the green liquid in the boiler 
		# Show the flame
		$BoilerSprite.frame = 6
		
		# Detect if the BoilTimer is not yet started
		if $BoilTimer.time_left == 0:
			$BoilTimer.start(globals.boil_time)
		
	else:
		# Show a light coloured liquid in the boiler
		$LiquidInBoiler.visible = true
		$LiquidInBoiler.region_rect = Rect2(142, 10, 5.177, 18.574) # This is zoomed in on a light coloured liquid
		# Hide the flame
		$BoilerSprite.frame = 0

# When the boil timer is done
func _on_boil_timer_timeout() -> void:
	# Change the state to done
	boiler_state = "done"
