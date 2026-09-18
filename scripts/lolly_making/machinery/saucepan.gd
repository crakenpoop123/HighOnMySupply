extends StaticBody2D

var ingredients_in_pot = false

# Changed this from a global var to a local one
var readable_name = "Saucepan"


func player_interact():
	if !ingredients_in_pot: # CHANGE SCENE DEPENDING ON STATE
		# Update this pot's value
		ingredients_in_pot = true
		
		if (globals.inventory_ingredients["sugar"]["stock"] > 0 # Check you have enough ingredients
		 and globals.inventory_ingredients["gelatin"]["stock"] > 0):
			# Decrease items from inventory
			globals.inventory_ingredients["sugar"]["stock"] -= 1
			globals.inventory_ingredients["gelatin"]["stock"] -= 1
			
			# Change the scene
			globals.change_scene(true, "res://scenes/minigames/gummy_worm_minigame.tscn")
		
		else: # Return the necessary ingredients, so that the user knows what they need to get
			return globals.inventory_ingredients["sugar"]["name"] + " or " + globals.inventory_ingredients["gelatin"]["name"]
	
	else:
		# Update this pot's value
		ingredients_in_pot = false
		
		# Give the player gummy worms
		globals.inventory_ingredients["gummy_worm"]["stock"] += 4
		
		globals.change_scene(true, "res://scenes/minigames/gummy_cooking_minigame.tscn")
