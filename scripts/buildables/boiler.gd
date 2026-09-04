extends StaticBody2D


# Player interacts with the buildable
func player_interact():
	# If the player has at least one cane juice
	if globals.inventory_ingredients["cane_juice"]["stock"] > 0:
		# Change the scene to the boiling minigame
		globals.change_scene(true, "res://scenes/minigames/boil_minigame.tscn")
	else:
		# Return the name of cane juice
		return globals.inventory_ingredients["cane_juice"]["name"]
