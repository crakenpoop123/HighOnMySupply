extends Node2D

const COOKING_MENU = preload("res://Scenes/lolly_making/lolly_making_menu.tscn")
const INVENTORY = preload("res://Scenes/menus/Inventory.tscn")

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void: 
	$MixTip.text = "Press E to start mixing ingrediants" # Origially the text changed so thats why this is here
	
func cooking_menu_inst(): #Make the menu appear
	var cooking_menu = COOKING_MENU.instantiate()
	$Menus.add_child(cooking_menu)
	
func inventory_inst():
	var inventory = INVENTORY.instantiate()
	$Menus.add_child(inventory)
