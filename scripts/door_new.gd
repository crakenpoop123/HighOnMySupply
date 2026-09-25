extends StaticBody2D

var readable_name = "Door"

# When the player interacts with the door
func player_interact():
	# Updates the player loading point
	globals.player_loading_point = get_parent().scene_from
	
	# Checks the door is not taking you to the saved scene
	if $"..".scene_to_load == "res://scenes/player/saved_scene.tscn":
		# Use the special saved scene code
		globals.change_scene(false)
	elif $"..".scene_to_load == "res://scenes/areas_in_world/basement.tscn":
		globals.load_scene(true)
	else:
		# Load the scene normally 
		globals.change_scene(true, $"..".scene_to_load)
