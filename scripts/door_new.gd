extends StaticBody2D
var readable_name = "Door"
func _ready() -> void:
	pass
	
func player_interact():
	globals.change_scene(true, $"..".scene_to_load)
	globals.player_loading_point = get_parent().scene_from
