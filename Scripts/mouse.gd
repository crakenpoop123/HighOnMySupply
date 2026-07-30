extends Node2D

var EMPTY
var holding_click = false
var holding = false
var mouse_in_area = false
var area_name: Area2D
@onready var mouse_pos = get_global_mouse_position()

func _process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		holding_click = true
	if Input.is_action_just_released("click"):
		holding_click = false
	
	$MouseArea/MouseCollision.global_position = mouse_pos


func _on_mouse_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if holding == false:
		mouse_in_area = true
		area_name = area


func _on_mouse_area_area_shape_exited(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if holding == false:
		mouse_in_area = false
		area_name = EMPTY
