extends StaticBody2D


# Player interacts with the buildable
func player_interact():
	# If the player has at least one shredded cane
	if globals.inventory_ingredients["shredded_cane"]["stock"] > 0:
		# Change the scene to the crushing minigame
		globals.change_scene(true, "res://scenes/minigames/crush_minigame.tscn")
	else:
		# Return the name of shredded cane
		return globals.inventory_ingredients["shredded_cane"]["name"]
