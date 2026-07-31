extends Node2D

@onready var mouse = $Mouse

func _ready() -> void:
	Globals.can_drag = false # SET THE MOUSE DRAG TO FALSE SO THAT CODE TO DRAG CAN BE ADDED HERE BECAUSE ANNOYING THINGS HAPPEN

func _process(_delta: float) -> void:
	
	
	
		
	
	
	
	if mouse.area_name.name != 'Nil':
		if mouse.area_name.name != "Saucepan":
			if mouse.holding == true and mouse.area_name: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
					mouse.area_name.global_position = get_global_mouse_position()
					if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
						mouse.holding = false # DROP IT

			if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
				if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
					if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
						mouse.holding = true # START DRAGGING
