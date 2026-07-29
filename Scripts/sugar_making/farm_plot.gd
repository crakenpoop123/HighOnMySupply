extends StaticBody2D

var player_can_interact = false

var growth_stage = 1 # I'm 1 indexing it because kys
var growth_rate = 1
var wetness = 0

var fully_grown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RandomGrowthTick.start(randf_range(Globals.sugar_cane_growth_min, Globals.sugar_cane_growth_max))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	growth_rate = 1 + $WetnessTimer.time_left / (Globals.dry_rate * 2)
	#print(growth_rate)

func player_interact():
	if fully_grown:
		harvest()
	else:
		water()
	

func water():
	#print("Watered")
	
	wetness = 1
	$WetnessTimer.start(Globals.dry_rate)

func harvest():
	Globals.sugar_cane += 1
	#print("Harvested sugar_cane, now at ", Globals.sugar_cane, " sugar cane")
	growth_stage = 0
	
	$RandomGrowthTick.start(randf_range(Globals.sugar_cane_growth_min, Globals.sugar_cane_growth_max) / growth_rate)

func _on_random_growth_tick_timeout() -> void:
	growth_stage = min(growth_stage + 1, Globals.sugar_cane_max_growth)
	
	fully_grown = growth_stage == Globals.sugar_cane_max_growth
	
	print("grew to stage ", growth_stage)
	
	if !fully_grown:
		$RandomGrowthTick.start(randf_range(Globals.sugar_cane_growth_min, Globals.sugar_cane_growth_max) / growth_rate)
