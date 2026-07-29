extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

var target_speed = Vector2.ZERO
var movement_smoothing = 5


func _process(_delta: float) -> void:
	check_for_farm()
	
	if Globals.in_menu == true:
		Globals.can_move = false
		velocity.x = 0
		velocity.y = 0
	else:
		Globals.can_move = true
	
	if Globals.farm_exists:
		find_farm_plots()
	
	interact()

func _physics_process(_delta: float) -> void:
	if Globals.can_move == true:
		move()
	else: # Stop the player from drifting when they shouldn't move
		target_speed = Vector2.ZERO
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	near_pot = true
	print(near_pot)

func _on_area_2d_area_exited(area: Area2D) -> void:
	near_pot = false
	print(near_pot)



func check_for_farm():
	Globals.farm_exists = $"..".has_node("Farm")

func find_farm_plots():
	var touching_any_plots = false
	for plot in $"..".get_node("Farm").get_children():
		plot.player_can_interact = is_interact_area_touching(plot)
		touching_any_plots = true
	return touching_any_plots

func find_machinery():
	if $"..".has_node("Machinery"):
		for machine in $"..".get_node("Machinery").get_children():
			if is_interact_area_touching(machine):
				return true
	return false


func get_nearest_machinery():
	var closest_dist = INF
	var closest_machine
	for machine in $"..".get_node("Machinery").get_children():
		var curr_dist = self.global_position.distance_to(machine.global_position)
		if is_interact_area_touching(machine) and curr_dist < closest_dist:
			closest_dist = curr_dist
			closest_machine = machine
	
	return closest_machine

func get_nearest_farm_plot():
	var closest_dist = INF
	var closest_plot
	for plot in $"..".get_node("Farm").get_children():
		var curr_dist = self.global_position.distance_to(plot.global_position)
		if is_interact_area_touching(plot) and curr_dist < closest_dist:
			closest_dist = curr_dist
			closest_plot = plot
	
	return closest_plot

func is_interact_area_touching(body):
	return body in $"InteractArea".get_overlapping_bodies()

func move():
	if Input.is_action_pressed("move_up"):
		target_speed[1] = -SPEED
	elif Input.is_action_pressed("move_down"):
		target_speed[1] = SPEED
	else:
		target_speed[1] = 0
	if Input.is_action_pressed("move_left"):
		target_speed[0] = -SPEED
	elif Input.is_action_pressed("move_right"):
		target_speed[0] = SPEED
	else:
		target_speed[0] = 0
	
	# Normalise the speed. This ensures diagonal movement is the same speed as rectilinear motion
	target_speed = target_speed.normalized() * SPEED
	
	velocity += (target_speed - velocity) / movement_smoothing


func interact():
	if Input.is_action_just_pressed("interact"):
		print("trying to interact")
		if Globals.in_menu == false:
			if near_pot == true:
				Globals.in_cooking_menu = true
				Globals.in_menu = true
				print("PLayer has interacted with the cooking menu")
				
				# Open the cooking menu
				$"..".cooking_menu_inst()
			elif find_farm_plots():
				print("Player has interacted with a farm plot")
				
				# Increase the growth rate of the plot slightly
				get_nearest_farm_plot().player_interact()
			elif find_machinery():
				print("Player has interacted with machinery")
				
				get_nearest_machinery().player_interact()
			else:
				print("Failed to interact with anything")
	if Input.is_action_just_pressed("inventory"):
		if Globals.in_inventory == false:
			print("inventory opened")
			Globals.in_inventory = true
			$"..".inventory_inst()
		else:
			print("already open")
