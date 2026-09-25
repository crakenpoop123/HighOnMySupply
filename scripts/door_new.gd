extends StaticBody2D
var readable_name = "Door"
func _ready() -> void:
	pass
	
func player_interact():
	globals.player_loading_point = get_parent().scene_from
	print($"..".scene_to_load)
	if $"..".scene_to_load != "res://scenes/player/saved_scene.tscn":
		globals.change_scene(true, $"..".scene_to_load)
	else:
		globals.change_scene(false)
