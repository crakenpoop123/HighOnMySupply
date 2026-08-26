extends StaticBody2D


func player_interact():
	globals.change_scene(true, $"..".scene_to_load)
