extends Node2D

var holding_click = false
var holding = false
var mouse_in_area = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		holding_click = true
	if Input.is_action_just_released("click"):
		holding_click = false
	
	$Mouse/MouseArea/MouseCollision.global_position = get_global_mouse_position()
	
	if holding == true:
		$Ingrediant.global_position = get_global_mouse_position()
	
	if mouse_in_area == true:
		if holding_click == true:
			holding = true
		else:
			holding = false
	elif mouse_in_area == false:
		holding = false


func _on_ingrediant_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	mouse_in_area = true

func _on_ingrediant_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	mouse_in_area = false
