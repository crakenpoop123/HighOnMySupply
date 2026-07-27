extends CanvasLayer
enum Menu {
	CLOSE_MENU,
	MENU_MENU,
	GUMMY_WORM_MENU,
	SUGAR_MAKING_MENU,
	GELATIN_BUYING_MENU
}

var menu = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Main/GummyManufacturing/GummyStock.text = "Gummy worms stock: " + str(Globals.gummy_worm_stock)
	$Main/SugarManufacturing/SugarStock.text = "Sugar stock: " + str(Globals.sugar)
	$Main/BuyGelatin/GelatinStock.text = "Gelatin stock: " + str(Globals.gelatin)
	
	if menu == Menu.CLOSE_MENU:
		Globals.in_menu = false
		Globals.in_cooking_menu = false
		self.queue_free()
	elif menu == Menu.MENU_MENU:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = true
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = false
	elif menu == Menu.GUMMY_WORM_MENU:
		$"Main/GummyManufacturing".visible = true
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = false
	elif menu == Menu.SUGAR_MAKING_MENU:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = true
		$Main/BuyGelatin.visible = false
	elif menu == Menu.GELATIN_BUYING_MENU:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = true
	else:
		print("Oh no, something bad happened :(")
func _on_button_2_button_up() -> void:
	print("Close Menu button pressed")
	if menu == 1:
		menu = 0
	else:
		menu = 1

func _make_gummy_worms() -> void:
	if Globals.sugar >= 1 and Globals.gelatin >= 1:
		Globals.gummy_worm_stock += 1
		Globals.sugar -= 1
		Globals.gelatin -= 1

func _open_gummy_menu() -> void:
	print("Opening Gummy Menu")
	menu = 2

func _open_sugar_menu() -> void:
	menu = 3

func _make_sugar() -> void: 
	Globals.sugar += 1

func _on_sugar_menu_2_button_up() -> void:
	menu = 4
	
func _on_buy_gelatin_button_up() -> void:
	Globals.gelatin += 1
