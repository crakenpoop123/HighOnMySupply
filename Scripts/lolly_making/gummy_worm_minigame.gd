extends Node2D

var holding_click = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		holding_click = true
		print(holding_click)
	if Input.is_action_just_released("click"):
		holding_click = false
		print(holding_click)
	
	$Mouse/MouseArea/MouseCollision.global_position = get_global_mouse_position()
