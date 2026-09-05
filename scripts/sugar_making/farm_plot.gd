extends StaticBody2D

var player_can_interact = false

var growth_stage = 1 # I'm 1 indexing it because kys
var growth_rate = 1
var wetness = 0

var fully_grown
var build_type = "farm_plot"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RandomGrowthTick.start(randf_range(globals.sugar_cane_growth_min, globals.sugar_cane_growth_max))
	
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
	saved_states.building_data[build_type][self.name]["stage"] = growth_stage
	saved_states.building_data[build_type][self.name]["wetness"] = wetness

# Loads the variable saved in the autoload saved_states:
func load_prev_state():
	# Loads the state of a few important variables
	growth_stage = saved_states.building_data[build_type][self.name]["stage"]
	wetness = saved_states.building_data[build_type][self.name]["wetness"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	wetness = $WetnessTimer.time_left
	
	growth_rate = 1 + wetness / (globals.dry_rate * 2)
	#print(growth_rate)
	if wetness != 0:
		$PlotSprite.animation = "growth_stages_wet"
	else:
		$PlotSprite.animation = "growth_stages_dry"
	$PlotSprite.frame = growth_stage
	

func player_interact():
	if fully_grown:
		harvest()
	else:
		water()
	

func water():
	print("Watered")
	
	wetness = 1
	$WetnessTimer.start(globals.dry_rate)

func harvest():
	globals.inventory_ingredients["sugar_cane"]["stock"] += 1
	print("Harvested sugar_cane, now at ", globals.inventory_ingredients["sugar_cane"]["stock"], " sugar cane")
	growth_stage = 0
	
	$PlotSprite.frame = growth_stage
	
	fully_grown = false
	
	$RandomGrowthTick.start(randf_range(globals.sugar_cane_growth_min, globals.sugar_cane_growth_max) / growth_rate)
	
	save_curr_state()
	
	globals.change_scene(true, "res://scenes/minigames/harvest_sugarcane_minigame.tscn")

func _on_random_growth_tick_timeout() -> void:
	growth_stage = min(growth_stage + 1, globals.sugar_cane_max_growth)
	
	fully_grown = growth_stage == globals.sugar_cane_max_growth
	
	#print("grew to stage ", growth_stage)
	
	if !fully_grown:
		$RandomGrowthTick.start(randf_range(globals.sugar_cane_growth_min, globals.sugar_cane_growth_max) / growth_rate)
