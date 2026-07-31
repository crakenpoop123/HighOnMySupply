extends Node2D

@onready var mouse = $Mouse
@onready var sugar = $Ingrediant
@onready var saucepan = $Saucepan

var all_ingrediants_in_pot = false

func _ready() -> void:
	Globals.can_drag = false # SET THE MOUSE DRAG TO FALSE SO THAT CODE TO DRAG CAN BE ADDED HERE BECAUSE ANNOYING THINGS HAPPEN

func _process(_delta: float) -> void:
	print("inside pot", sugar.inside_pot)
	print("everything in pot", all_ingrediants_in_pot)
	
	
	
	if mouse.area_name: # IF THE NAME IS NOT NIL
		if all_ingrediants_in_pot == false:
			if mouse.area_name.name != "Saucepan": # IF THE NAME IS NOT SAUCEPAN
				check_for_move()
				check_for_drop()
		elif all_ingrediants_in_pot == true:
			check_for_move()
			check_for_drop()
	
	
	
	
func check_for_move():
	if mouse.holding == true: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		mouse.area_name.global_position = get_global_mouse_position() # MOVE THE ITEM
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT
			if sugar.inside_pot == true:
				sugar.reparent(saucepan)
				all_ingrediants_in_pot = true

func check_for_drop():
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING
