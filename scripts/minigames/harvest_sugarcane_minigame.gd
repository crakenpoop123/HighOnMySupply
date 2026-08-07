extends Node2D

@onready var mouse = $Mouse

var hit_sugarcane: bool = false


func _process(_delta: float) -> void:
	if hit_sugarcane == true: # When you are doing something with speed you will probably need to change this clark
		Globals.change_scene(false)
	
	if mouse.area_name: # IF THE NAME IS NOT NIL
		if mouse.area_name.name != "Sugarcane": # IF THE NAME IS NOT SUGARCANE
			Globals.can_drag = true
		else:
			Globals.can_drag = false
	
	print(mouse.area_name, " ", Globals.can_drag)

func _on_blade_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent().name == "Sugarcane":
		hit_sugarcane = true

func hit_too_slow(): # Func for you clark
	$Tip.visible = true
