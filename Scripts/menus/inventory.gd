extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Main/SugarStock.text = str("Sugar: ", Globals.sugar)
	$Main/GelatinStock.text = str("Gelatin: ", Globals.gelatin)
	$Main/GummyStock.text = str("Gummy worms: ", Globals.gummy_worm_stock)
	$Main/Money.text = str("Money: ", Globals.money)
	
func _on_close_button_button_up() -> void:
	self.queue_free()
	Globals.in_inventory = false
