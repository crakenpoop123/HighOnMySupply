extends Node2D

@onready var mouse = $Mouse

var hit_sugarcane: bool = false
var min_chop_speed = 30

var pivot_offset = Vector2.ZERO
var knife_angle = 0

var slow_tip_timeout = 3.5

func _process(_delta: float) -> void:
	if hit_sugarcane == true: # When you are doing something with speed you will probably need to change this clark
		globals.change_scene(false)
	
	if mouse.area_name: # IF THE NAME IS NOT NIL
		if mouse.area_name.name == "CaneKnife" and mouse.holding_click:
			lock_knife_to_discrete()
		if mouse.area_name.name != "Sugarcane": # IF THE NAME IS NOT SUGARCANE
			globals.can_drag = true
		else:
			globals.can_drag = false
	
	#print(mouse.area_name, " ", globals.can_drag)

func lock_knife_to_discrete(num_directions = 8):
	var total_val = (mouse.movement_dir + PI) / (2*PI) * num_directions
	var nearest_lock = floor(total_val)
	var locked_angle = nearest_lock * 2 * PI / num_directions - PI
	
	print("discrete dir", total_val)
	print("locked dir", nearest_lock)
	print("locked angle", locked_angle)
	
	offset_node2d($CaneKnife, get_global_mouse_position())
	$CaneKnife.rotation = locked_angle

func _physics_process(delta: float) -> void:
	
	for ray in $CaneKnife/Blade/BladeRays.get_children():
		rotate_to_mouse(ray, PI/2)
		#print($CaneKnifeOLD/Blade/BladeRay.get_collider())
		if ray.is_colliding():
			#print("Blade colliding with: ", ray.get_collider().get_parent().name)
			if ray.get_collider().get_parent().name == "Sugarcane":
				if mouse.movement_speed >= min_chop_speed:
					hit_sugarcane = true
				else:
					hit_too_slow()

func offset_node2d(node, pivot):
	pivot_offset = pivot - node.position
	
	node.position = pivot
	
	for child in node.get_children():
		child.position -= pivot_offset

func rotate_to_mouse(body, offset):
	#print(body.rotation)
	body.rotation = mouse.movement_dir + offset

func _on_blade_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#print(mouse.movement_speed)
	if area.get_parent().name == "Sugarcane":
		if mouse.movement_speed >= min_chop_speed:
			hit_sugarcane = true
		else:
			hit_too_slow()
 
func hit_too_slow(): # Func for you clark
	$Tip.visible = true
	$Tip/TipTimer.start(slow_tip_timeout)


func _on_tip_timer_timeout() -> void:
	$Tip.visible = false
