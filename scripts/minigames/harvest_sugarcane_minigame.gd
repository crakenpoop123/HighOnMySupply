extends Node2D

@onready var mouse = $Mouse

var hit_sugarcane: bool = false
var min_chop_speed = 30

var pivot_offset = Vector2.ZERO
var knife_angle = 0
var default_positions: Dictionary

var slow_tip_timeout = 3.5

func _ready() -> void:
	$Mouse/Camera.global_position = Vector2(-142, 11)
	note_node2d_positions($CaneKnife)

func _process(_delta: float) -> void:
	if hit_sugarcane == true:
		globals.change_scene(false)
	
	if mouse.area_name: # If the mouse is touching an area
		# Check if the mouse is touching the CaneKnife
		if mouse.area_name.name == "CaneKnife" and mouse.holding_click:
			lock_knife_to_discrete()
		if mouse.area_name.name != "Sugarcane":
			globals.can_drag = true
		else:
			globals.can_drag = false


# Lock the knife to discrete rotation intervals
# Makes the rotation look less glitchy
func lock_knife_to_discrete(num_directions = 8):
	# Normalise the direction of the knife in terms of num_directions
	var total_val = (mouse.movement_dir + PI) / (2*PI) * num_directions
	# Round this to lock it to discrete angles
	var nearest_lock = floor(total_val)
	# Convert this back to radians so that the knife can be rotated accordingly
	var locked_angle = nearest_lock * 2 * PI / num_directions - PI
	
	#print("discrete dir", total_val)
	#print("locked dir", nearest_lock)
	#print("locked angle", locked_angle)
	
	# Move the children of the knife in the opposite direction of the mouse
	# This allows the knife to be pivoted around the mouse
	offset_node2d($CaneKnife, get_global_mouse_position())
	$CaneKnife.rotation = locked_angle

func _physics_process(delta: float) -> void:
	# Check if a ray is colliding with the sugar cane
	# This is used to prevent tunneling
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

# Move the children of a node away from a certain point
# This is used for pivoting the knife around the mouse
func offset_node2d(node, pivot):
	pivot_offset = pivot - node.position
	
	for child in node.get_children():
		child.position -= pivot_offset
		
	node.position = pivot
	$PivotVisualiser.position = pivot

func note_node2d_positions(node):
	for child in node.get_children():
		default_positions[child.name] = child.position

func center_node2d(node):
	for child in node.get_children():
		child.position = default_positions[child.name]
	
	pivot_offset = mouse.get_global_mouse_position() - node.position

# Func to rotate the tunneling rays
func rotate_to_mouse(body, offset):
	#print(body.rotation)
	body.rotation = mouse.movement_dir + offset

# Chop the sugarcane when it gets hit
func _on_blade_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	# Check it is hitting the sugarcane
	if area.get_parent().name == "Sugarcane":
		# Ensure the mouse is fast
		if mouse.movement_speed >= min_chop_speed:
			hit_sugarcane = true
		else:
			hit_too_slow()
 
# Tell the player they need to move the knife fast
func hit_too_slow():
	$Tip.visible = true
	$Tip/TipTimer.start(slow_tip_timeout)

# Close the tip
func _on_tip_timer_timeout() -> void:
	$Tip.visible = false
