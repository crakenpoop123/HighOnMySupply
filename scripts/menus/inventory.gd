extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Main/SugarStock.text = str("Sugar: ", globals.sugar)
	$Main/GelatinStock.text = str("Gelatin: ", globals.gelatin)
	$Main/GummyStock.text = str("Gummy worms: ", globals.gummy_worm_stock)
	$Main/Money.text = str("Money: ", globals.money)
	
func _on_close_button_button_up() -> void:
	self.queue_free()
	globals.in_inventory = false
