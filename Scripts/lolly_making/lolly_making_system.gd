extends Node2D

const COOKING_MENU = preload("res://Scenes/lolly_making/lolly_making_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Text.text = "Press E to start mixing ingrediants"
	
func cooking_menu_inst():
	var cooking_menu = COOKING_MENU.instantiate()
	$Menus.add_child(cooking_menu)
	
