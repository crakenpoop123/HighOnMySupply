extends StaticBody2D

var saucepan_on_table = true

func _process(_delta: float) -> void:
	pass
	#if globals.saucepan_on_table == true: # CHANGE LOCATION DEPENDING ON STATE
		#$".".position = Vector2(-650, -43)
	#elif globals.saucepan_on_table == false:
		#$".".position = Vector2(-752, -28)


func player_interact():
	if saucepan_on_table == true: # CHANGE SCENE DEPENDING ON STATE
		if (globals.inventory_ingredients["sugar"]["stock"] > 0 # Check you have enough ingredients
		 and globals.inventory_ingredients["gelatin"]["stock"] > 0):
			globals.inventory_ingredients["sugar"]["stock"] -= 1
			globals.inventory_ingredients["gelatin"]["stock"] -= 1
			globals.change_scene(true, "res://scenes/minigames/gummy_worm_minigame.tscn")
		else: # Return the necessary ingredients, so that the user knows what they need to get
			return globals.inventory_ingredients["sugar"]["name"] + " or " + globals.inventory_ingredients["gelatin"]["name"]
	elif saucepan_on_table == false:
		globals.change_scene(true, "res://scenes/minigames/gummy_cooking_minigame.tscn")
