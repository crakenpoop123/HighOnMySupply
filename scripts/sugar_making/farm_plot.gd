extends StaticBody2D

var player_can_interact = false

var growth_stage = 1 # I'm 1 indexing it because kys
var growth_rate = 1
var wetness = 0

var fully_grown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RandomGrowthTick.start(randf_range(globals.sugar_cane_growth_min, globals.sugar_cane_growth_max))


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
	print(wetness)

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
	globals.sugar_cane += 1
	print("Harvested sugar_cane, now at ", globals.sugar_cane, " sugar cane")
	growth_stage = 0
	
	$PlotSprite.frame = growth_stage
	
	fully_grown = false
	
	$RandomGrowthTick.start(randf_range(globals.sugar_cane_growth_min, globals.sugar_cane_growth_max) / growth_rate)
	
	globals.change_scene(true, "res://scenes/minigames/harvest_sugarcane_minigame.tscn")

func _on_random_growth_tick_timeout() -> void:
	growth_stage = min(growth_stage + 1, globals.sugar_cane_max_growth)
	
	fully_grown = growth_stage == globals.sugar_cane_max_growth
	
	#print("grew to stage ", growth_stage)
	
	if !fully_grown:
		$RandomGrowthTick.start(randf_range(globals.sugar_cane_growth_min, globals.sugar_cane_growth_max) / growth_rate)
