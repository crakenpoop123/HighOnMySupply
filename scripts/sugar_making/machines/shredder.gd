extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_interact():
	print("Shredded", shred(min(2, globals.sugar_cane)))

func shred(sugar_cane):
	print("Shreddy Mc shredface")
	return sugar_cane
