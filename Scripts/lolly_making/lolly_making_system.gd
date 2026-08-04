extends Node2D

const COOKING_MENU = preload("res://Scenes/lolly_making/lolly_making_menu.tscn")

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void: 
	$MixTip.text = "Press E to start mixing ingrediants" # Origially the text changed so thats why this is here
	
