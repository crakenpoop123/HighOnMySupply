extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func player_interact():
	# If the player has at least one shredded cane
	if globals.inventory_ingredients["shredded_cane"]["stock"] > 0:
		# Change the scene to the crushing minigame
		globals.change_scene(true, "res://scenes/minigames/crush_minigame.tscn")
	else:
		# Return the name of shredded cane
		return globals.inventory_ingredients["shredded_cane"]["name"]
