extends StaticBody2D
var readable_name = "Door"
func _ready() -> void:
	pass
	
func player_interact():
	globals.player_loading_point = get_parent().scene_from
	globals.change_scene(true, $"..".scene_to_load)
