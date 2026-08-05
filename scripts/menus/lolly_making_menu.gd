extends CanvasLayer
enum Menu {
	CLOSE_MENU,
	MENU_MENU,
	GUMMY_WORM_MENU,
	SUGAR_MAKING_MENU,
	GELATIN_BUYING_MENU,
	temp_sell_gummy_worm
}

var menu = 1

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void: 
		# Update text
	$Main/GummyManufacturing/GummyStock.text = "Gummy worms stock: " + str(Globals.gummy_worm_stock)
	$Main/SugarManufacturing/SugarStock.text = "Sugar stock: " + str(Globals.sugar)
	$Main/BuyGelatin/GelatinStock.text = "Gelatin stock: " + str(Globals.gelatin)
	$Main/SellMenu/Money.text = "money: " + str(Globals.money)

		# All the menus to make them visible or not
	if menu == Menu.CLOSE_MENU:
		Globals.in_menu = false
		Globals.in_cooking_menu = false
		self.queue_free()
	elif menu == Menu.MENU_MENU:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = true
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = false
		$Main/SellMenu.visible = false
	elif menu == Menu.GUMMY_WORM_MENU:
		$"Main/GummyManufacturing".visible = true
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = false
		$Main/SellMenu.visible = false
	elif menu == Menu.SUGAR_MAKING_MENU:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = true
		$Main/BuyGelatin.visible = false
		$Main/SellMenu.visible = false
	elif menu == Menu.GELATIN_BUYING_MENU:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = true
		$Main/SellMenu.visible = false
	elif menu == Menu.temp_sell_gummy_worm:
		$"Main/GummyManufacturing".visible = false
		$Main/MainMenu.visible = false
		$Main/SugarManufacturing.visible = false
		$Main/BuyGelatin.visible = false
		$Main/SellMenu.visible = true
	else:
		print("Oh no, something bad happened :(")

func _on_button_2_button_up() -> void: # Back button
	print("Close Menu button pressed")
	if menu == 1: # Code so that the menu closes on page 1
		menu = 0
	else:
		menu = 1

func _make_gummy_worms() -> void: # Make the gummy worms
	if Globals.sugar >= 1 and Globals.gelatin >= 1:
		Globals.gummy_worm_stock += 1
		Globals.sugar -= 1
		Globals.gelatin -= 1

func _open_gummy_menu() -> void: # Open the gummy worm menu to make gummy worms 
	print("Opening Gummy Menu")
	menu = 2

func _open_sugar_menu() -> void: # Open the sugar menu
	menu = 3

func _make_sugar() -> void:  # Sugar button that gives you sugar
	Globals.sugar += 1

func _on_sugar_menu_2_button_up() -> void: # Open the gelatin menu
	menu = 4
	
func _on_buy_gelatin_button_up() -> void: # Gelatin button that gives you gelatin
	if Globals.money >= 5:
		Globals.gelatin += 1
		Globals.money -= 5

func _on_sell_gummy_worm_button_up() -> void: # Open the sell menu
	menu = 5

func _on_sell_button_button_up() -> void: # Sell 1 gummy worm for 10 money
	if Globals.gummy_worm_stock >= 1: 
		Globals.gummy_worm_stock -= 1
		Globals.money += 10
