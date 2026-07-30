extends Node2D

var holding_click = false
var holding = false
var mouse_in_area = false
var mouse_pos = get_global_mouse_position()

func _process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		holding_click = true
	if Input.is_action_just_released("click"):
		holding_click = false
	
	$MouseArea/MouseCollision.global_position = mouse_pos
