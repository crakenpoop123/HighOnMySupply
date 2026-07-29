extends StaticBody2D

var player_can_interact = false

var growth = 0
var growth_rate = 1
var wetness = 0

var fully_grown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RandomGrowthTick.start(randf_range(Globals.sugar_cane_growth_min, Globals.sugar_cane_growth_max))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Most golf is boring
	growth_rate = 1 + $WetnessTimer.time_left / (Globals.dry_rate * 2)
	#print(growth_rate)

func water():
	wetness = 1
	$WetnessTimer.start(Globals.dry_rate)


func _on_random_growth_tick_timeout() -> void:
	growth = min(growth + 1, Globals.sugar_cane_max_growth)
	
	print(growth == Globals.sugar_cane_max_growth)
	fully_grown = growth == Globals.sugar_cane_max_growth
	
	print("grew to stage ", growth)
	
	if !fully_grown:
		$RandomGrowthTick.start(randf_range(Globals.sugar_cane_growth_min, Globals.sugar_cane_growth_max) / growth_rate)
