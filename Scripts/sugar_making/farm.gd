extends StaticBody2D

var player_can_interact = false

var growth = 0
var growth_rate = 1
var wetness = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Most golf is boring
	growth_rate = 1 + $WetnessTimer.time_left / (Globals.dry_rate * 2)
	print(growth_rate)

func water():
	wetness = 1
	$WetnessTimer.start(Globals.dry_rate)
