extends Node2D

@onready var mouse = $Mouse

var hit_sugarcane: bool = false

var all_ingrediants_in_pot = false
var ingredients_in_pot = 0

func _ready() -> void:
	Globals.can_drag = false # SET THE MOUSE DRAG TO FALSE SO THAT CODE TO DRAG CAN BE ADDED HERE BECAUSE ANNOYING THINGS HAPPEN
	
func _process(_delta: float) -> void:
	if hit_sugarcane == true: # When you are doing something with speed you will probably need to change this clark
		Globals.change_scene(false)
	

	if mouse.area_name: # IF THE NAME IS NOT NIL
		if all_ingrediants_in_pot == false:
			if mouse.area_name.name != "Sugarcane": # IF THE NAME IS NOT SAUCEPAN
				check_for_move()
				check_for_drop()

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


func _on_blade_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent().name == "Sugarcane":
		hit_sugarcane = true

func hit_too_slow(): # Func for you clark
	$Tip.visible = true
