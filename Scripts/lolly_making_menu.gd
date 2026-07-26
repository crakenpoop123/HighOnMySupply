extends CanvasLayer
enum Menu {
	CLOSE_MENU,
	MENU_MENU,
	GUMMY_WORM_MENU
}

var menu = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"Main/Gummy worm manufacturing/RichTextLabel".text = "Gummy worms stock: " + str(Globals.gummy_worm_stock)
	
	if menu == Menu.CLOSE_MENU:
		self.queue_free()
		Globals.in_menu = false
		Globals.in_cooking_menu = false
		
func _on_button_2_button_up() -> void:
	menu = 0
	


func _make_gummy_button() -> void:
	Globals.gummy_worm_stock += 1
