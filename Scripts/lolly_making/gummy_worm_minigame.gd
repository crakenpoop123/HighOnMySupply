extends Node2D

@onready var mouse = $Mouse

func _process(_delta: float) -> void:
	if mouse.holding == true and mouse.area_name.get_parent(): # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		mouse.area_name.get_parent().global_position = get_global_mouse_position()

	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING
			
	elif mouse.holding == true:# IF YOU ARE HOLDING SOMETHING
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
				mouse.holding = false # DROP IT
	
