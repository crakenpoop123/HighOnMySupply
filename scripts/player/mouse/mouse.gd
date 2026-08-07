extends Node2D

var EMPTY
var holding_click = false
var holding = false
var mouse_in_area = false
var area_name: Node2D
var also_area_name
@onready var mouse_pos = get_global_mouse_position()
var prev_mouse_pos: Array = [0, 0, 0, 0, 0]
var prev_pos_size = 5

var movement_speed = 0
var movement_dir = 0

func _ready():
	prev_mouse_pos.fill(get_global_mouse_position())

func _process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	
	if Input.is_action_just_pressed("click"):
		holding_click = true
	if Input.is_action_just_released("click"):
		holding_click = false
	#print(mouse_in_area)
	$MouseArea/MouseCollision.global_position = mouse_pos
	if Globals.can_drag == true:
		check_for_move()
		check_for_drop()
		check_off_screen()
		get_movement_data()
	
	prev_mouse_pos.pop_back()
	prev_mouse_pos.insert(0, mouse_pos)



func get_movement_data():
	movement_speed = (mouse_pos - prev_mouse_pos[0]).length()
	
	print("prev pos", prev_mouse_pos)
	print("pos", mouse_pos)
	if prev_mouse_pos[4] != mouse_pos:
		movement_dir = (prev_mouse_pos[4] - mouse_pos).angle()
	print("direction", movement_dir)

func check_for_move():
	if holding == true: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		area_name.global_position += mouse_pos - prev_mouse_pos[0] # MOVE THE ITEM
		if holding_click == false: # IF YOU ARENT HOLDING CLICK
			holding = false # DROP IT


func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if holding_click == true: # AND YOU ARE HOLDING CLICK
				holding = true # START DRAGGING # Should't this be stop dragging???

func check_off_screen():
	if !area_name:
		return
	var area_x = area_name.global_position[0]
	var area_y = area_name.global_position[1]
	
	var window = get_window().size
	
	
	area_x = clamp(area_x, -window.x/2 - 145, window.x/2 - 135)
	area_y = clamp(area_y, -window.y/2, window.y/2)
	
	area_name.global_position = Vector2(area_x, area_y)

func _on_mouse_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	mouse_in_area = true
	if holding == false:
		area_name = area.get_parent() # THIS DOESN'T WORK THAT GREAT BUT IT SHOULDN'T BE AN ISSUE 
	
func _on_mouse_area_area_shape_exited(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	mouse_in_area = false
	if holding == false:
		area_name = EMPTY
