extends StaticBody2D

# Player interacts with the buildable
func player_interact():
	# If the player has at least 1 sugar cane
	if globals.inventory_ingredients["sugar_cane"]["stock"] > 0:
		# Change scene to the shredding minigame
		globals.change_scene(true, "res://scenes/lolly_making/shredding_minigame.tscn")
	else:
		# Return the name of sugar cane
		return globals.inventory_ingredients["sugar_cane"]["name"]
