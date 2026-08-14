extends Node2D

@onready var mouse = $Mouse
@onready var sugar = $Table/Sugar
@onready var saucepan = $Table/Saucepan
@onready var gelatin = $Table/Gelatin
@onready var water = $Table/Water


var empty_saucepan = load("res://assets/misc/saucepan.png")
var water_saucepan = load("res://assets/misc/water-saucepan.png")
var all_ingrediants_in_pot = false
var ingredients_in_pot = 0
var starting_to_close: bool = false
	
func _process(_delta: float) -> void:
	if ingredients_in_pot == 3:
		if starting_to_close == false:
			all_ingrediants_in_pot = true
			move_to_stove()
			starting_to_close = true
	elif ingredients_in_pot == 2:
		gelatin.visible = true

	print(all_ingrediants_in_pot)
	print(globals.can_drag)
	
	check_for_move()
	check_for_drop()
	if mouse.area_name: # IF THE NAME IS NOT NIL
		if all_ingrediants_in_pot == false:
			if mouse.area_name.name != "Saucepan": # IF THE NAME IS NOT SAUCEPAN
				globals.can_drag = true
		elif all_ingrediants_in_pot == true:
			globals.can_drag = true
		else:
			globals.can_drag = false

func check_for_move():
	if mouse.holding == false: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT
			if sugar.inside_pot == true:
				$Table/Sugar/IngrediantArea.queue_free()
				sugar.reparent(saucepan)
				sugar.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if gelatin.inside_pot == true:
				$Table/Gelatin/IngrediantArea.queue_free()
				gelatin.reparent(saucepan)
				gelatin.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if water.inside_pot == true:
				$Table/Saucepan/SaucepanSprite.texture = water_saucepan
				$Table/Water/IngrediantArea.queue_free()
				$Table/Water/IngrediantSprite.queue_free()
				water.reparent(saucepan)
				water.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
				
func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING # Should't this be stop dragging???

	
#func _on_close_timer_timeout() -> void:
	
	#globals.saucepan_on_table = false
	#globals.change_scene(false)
	
func move_to_stove():
	var tween = get_tree().create_tween()
	tween.tween_property($Mouse/Camera, "position", Vector2(-600, 0), 1.0)
