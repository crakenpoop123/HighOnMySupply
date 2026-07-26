extends CanvasLayer
enum Menu {
	CLOSE_MENU,
	MENU_MENU,
	GUMMY_WORM_MENU,
	SUGAR_MAKING_MENU
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
	elif menu == Menu.MENU_MENU:
		$"Main/Gummy worm manufacturing".visible = false
		$Main/MainMenu.visible = true
		$Main/Sugar.visible = false
	elif menu == Menu.GUMMY_WORM_MENU:
		$"Main/Gummy worm manufacturing".visible = true
		$Main/MainMenu.visible = false
		$Main/Sugar.visible = false
	elif menu == Menu.SUGAR_MAKING_MENU:
		$"Main/Gummy worm manufacturing".visible = false
		$Main/MainMenu.visible = false
		$Main/Sugar.visible = true
		
func _on_button_2_button_up() -> void:
	menu -= 1

func _make_gummy_button() -> void:
	if Globals.sugar >= 1:
		Globals.gummy_worm_stock += 1
		Globals.sugar -= 1

func _on_button_button_up() -> void:
	menu = 2


func _make_sugar_button() -> void:
	menu = 3


func _make_sugar_sugar_button() -> void:
	Globals.sugar += 1
