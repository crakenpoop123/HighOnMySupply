extends StaticBody2D


func _process(_delta: float) -> void:
	if globals.saucepan_on_table == true: # CHANGE LOCATION DEPENDING ON STATE
		$".".position = Vector2(-650, -43)
	elif globals.saucepan_on_table == false:
		$".".position = Vector2(-752, -28)


func player_interact():
	if globals.saucepan_on_table == true: # CHANGE SCENE DEPENDING ON STATE
		globals.change_scene(true, "res://scenes/lolly_making/gummy_worm_minigame.tscn")
	elif globals.saucepan_on_table == false:
		globals.change_scene(true, "res://scenes/lolly_making/gummy_cooking_minigame.tscn")
