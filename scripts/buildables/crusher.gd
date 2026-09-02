extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_interact():
	if globals.inventory_ingredients["shredded_cane"]["stock"] > 0:
		globals.change_scene(true, "res://scenes/minigames/crush_minigame.tscn")
