extends Node2D

@onready var mouse = $Mouse
@onready var sugar = $Sugar
@onready var saucepan = $Saucepan
@onready var gelatin = $Gelatin
@onready var water = $Water


var empty_saucepan = load("res://assets/misc/saucepan.png")
var water_saucepan = load("res://assets/misc/water-saucepan.png")
var all_ingrediants_in_pot = false
var ingredients_in_pot = 0

func _ready() -> void:
	globals.can_drag = false # SET THE MOUSE DRAG TO FALSE SO THAT CODE TO DRAG CAN BE ADDED HERE BECAUSE ANNOYING THINGS HAPPEN
	gelatin.visible = false
	
func _process(_delta: float) -> void:
	#print("inside pot", sugar.inside_pot)
	#print("everything in pot", all_ingrediants_in_pot)
	if ingredients_in_pot == 3:
		all_ingrediants_in_pot = true
		globals.saucepan_on_table = false
		globals.change_scene(false)
	elif ingredients_in_pot == 2:
		gelatin.visible = true

	#print(ingredients_in_pot)

	check_for_move()
	check_for_drop()
	if mouse.area_name: # IF THE NAME IS NOT NIL
		if all_ingrediants_in_pot == false:
			if mouse.area_name.name != "Saucepan": # IF THE NAME IS NOT SAUCEPAN
				globals.can_drag = true
			else:
				globals.can_drag = false
		elif all_ingrediants_in_pot == true:
			globals.can_drag = true
		else:
			globals.can_drag = false

func check_for_move():
	if mouse.holding == false: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		#mouse.area_name.global_position = get_global_mouse_position() # MOVE THE ITEM
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT
			if sugar.inside_pot == true:
				$Sugar/IngrediantArea.queue_free()
				sugar.reparent(saucepan)
				sugar.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if gelatin.inside_pot == true:
				$Gelatin/IngrediantArea.queue_free()
				gelatin.reparent(saucepan)
				gelatin.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if water.inside_pot == true:
				$Saucepan/SaucepanSprite.texture = water_saucepan
				$Water/IngrediantArea.queue_free()
				$Water/IngrediantSprite.queue_free()
				water.reparent(saucepan)
				water.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
				
				
			

func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING # Should't this be stop dragging???
