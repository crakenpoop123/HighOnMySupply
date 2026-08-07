extends Node2D

@onready var mouse = $Mouse
@onready var saucepan = $Saucepan




func _ready() -> void:
	Globals.can_drag = false # SET THE MOUSE DRAG TO FALSE SO THAT CODE TO DRAG CAN BE ADDED HERE BECAUSE ANNOYING THINGS HAPPEN

	
func _process(_delta: float) -> void:

	if mouse.area_name: # IF THE NAME IS NOT NIL
		Globals.can_drag = true

func check_for_move():
	if mouse.holding == true: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		mouse.area_name.global_position = get_global_mouse_position() # MOVE THE ITEM
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT

			

func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING # Should't this be stop dragging???


func _on_button_button_up() -> void:
	Globals.change_scene(false)
