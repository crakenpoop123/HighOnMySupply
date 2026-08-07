extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func player_interact():
	if globals.saucepan_on_table == true:
		globals.change_scene(true, "res://scenes/lolly_making/gummy_worm_minigame.tscn")
	elif globals.saucepan_on_table == false:
		globals.change_scene(true, "res://scenes/lolly_making/gummy_cooking_minigame.tscn")
