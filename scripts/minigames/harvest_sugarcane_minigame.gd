extends Node2D

@onready var mouse = $Mouse

var hit_sugarcane: bool = false
var min_chop_speed = 50

func _process(_delta: float) -> void:
	if hit_sugarcane == true: # When you are doing something with speed you will probably need to change this clark
		Globals.change_scene(false)
	
	if mouse.area_name: # IF THE NAME IS NOT NIL
		if mouse.area_name.name != "Sugarcane": # IF THE NAME IS NOT SUGARCANE
			Globals.can_drag = true
		else:
			Globals.can_drag = false
	
	#print(mouse.area_name, " ", Globals.can_drag)

func _physics_process(delta: float) -> void:
	rotate_to_mouse($CaneKnife)
	for ray in $CaneKnife/Blade/BladeRays.get_children():
		rotate_to_mouse(ray)
		#print($CaneKnifeOLD/Blade/BladeRay.get_collider())
		if ray.is_colliding():
			print("Blade colliding with: ", ray.get_collider().get_parent().name)
			if ray.get_collider().get_parent().name == "Sugarcane" and mouse.movement_speed >= min_chop_speed:
				hit_sugarcane = true

func rotate_to_mouse(body):
	print(body.rotation)
	body.rotation = mouse.movement_dir + PI/2

func _on_blade_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print(mouse.movement_speed)
	#if area.get_parent().name == "Sugarcane" and mouse.movement_speed >= min_chop_speed:
		#hit_sugarcane = true
 
func hit_too_slow(): # Func for you clark
	$Tip.visible = true
