extends StaticBody2D

# Changed this from a global var to a local one
var saucepan_on_table = true


func player_interact():
	if saucepan_on_table == true: # CHANGE SCENE DEPENDING ON STATE
		if (globals.inventory_ingredients["sugar"]["stock"] > 0 # Check you have enough ingredients
		 and globals.inventory_ingredients["gelatin"]["stock"] > 0):
			# Decrease items from inventory
			globals.inventory_ingredients["sugar"]["stock"] -= 1
			globals.inventory_ingredients["gelatin"]["stock"] -= 1
			
			# Change the scene
			globals.change_scene(true, "res://scenes/minigames/gummy_worm_minigame.tscn")
		
		else: # Return the necessary ingredients, so that the user knows what they need to get
			return globals.inventory_ingredients["sugar"]["name"] + " or " + globals.inventory_ingredients["gelatin"]["name"]
	
	else: # saucepan_on_table == false
		globals.change_scene(true, "res://scenes/minigames/gummy_cooking_minigame.tscn")
