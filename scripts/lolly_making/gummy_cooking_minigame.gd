extends Node2D

@onready var mouse = $Mouse
@onready var saucepan = $Table/Saucepan

var empty_saucepan = load("res://assets/misc/saucepan.png")
var water_saucepan = load("res://assets/misc/water-saucepan.png")
var all_ingrediants_in_pot = false
var ingredients_in_pot = 0
var starting_to_close: bool = false

func _ready() -> void:
	$Mouse/Camera.global_position = Vector2(-300, 0)
	saucepan.in_cooking_scene = true
	
func _process(_delta: float) -> void:
	
	check_for_move()
	check_for_drop()

func check_for_move():
	if mouse.holding == false: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT
			
				
func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING # Should't this be stop dragging???

	

func _on_timer_timeout() -> void:
	globals.saucepan_on_table = false
	globals.change_scene(false)
	
