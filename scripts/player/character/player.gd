extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

var target_speed = Vector2.ZERO
var movement_smoothing = 5

var attack_speed = 2 # interval(secs) between attacks
var player_dir = 0
var dir_state = "down"

var slot_focused = 0

func _ready():
	print("key type", int(KEY_0))

func _process(_delta: float) -> void:
	if globals.in_menu or globals.in_inventory:
		globals.can_move = false
	else:
		globals.can_move = true
	
	interact()
	check_hotbar_focus()

func _physics_process(_delta: float) -> void:
	if globals.can_move == true:
		move()
		get_player_dir()
		orient_animation()
	else: # Stop the player from drifting when they shouldn't move
		target_speed = Vector2.ZERO
		
	# Normalise the speed. This ensures diagonal movement is the same speed as rectilinear motion
	target_speed = target_speed.normalized() * SPEED
	
	velocity += (target_speed - velocity) / movement_smoothing
	
	if globals.can_attack:
		check_for_attacks()
	
	move_and_slide()


func _on_area_2d_area_entered(_area: Area2D) -> void: # This stuff aint needed anymore
	near_pot = true
	print(near_pot)

func _on_area_2d_area_exited(_area: Area2D) -> void: # This stuff aint needed anymore
	near_pot = false
	print(near_pot)


func find_interactables():
	for interactable_parent in globals.interactable_parents:
		if $"..".has_node(interactable_parent):
			for interactable in $"..".get_node(interactable_parent).get_children():
				if is_interact_area_touching(interactable):
					return true
	return false

func get_nearest_interactable():
	var closest_dist = INF
	var closest_interactable
	for interactable_parent in globals.interactable_parents:
		if $"..".has_node(interactable_parent):
			for interactable in $"..".get_node(interactable_parent).get_children():
				var curr_dist = self.global_position.distance_to(interactable.global_position)
				if is_interact_area_touching(interactable) and curr_dist < closest_dist:
					closest_dist = curr_dist
					closest_interactable = interactable
	
	return closest_interactable

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
	
	
	

func get_player_dir():
	if target_speed.length() != 0:
		player_dir = target_speed.angle()
		#print("player direction", player_dir)d

func orient_animation():
	if player_dir >= -PI/4 - 0.001 and player_dir <= PI/4 + 0.001:
		dir_state = "right"
	elif player_dir >= 3*PI/4 or player_dir <= -3*PI/4:
		dir_state = "left"
	elif player_dir > PI/4 and player_dir < 3*PI/4:
		dir_state = "down"
	elif player_dir > -3 * PI/4 and player_dir < -PI/4:
		dir_state = "up"
	#print(dir_state)
	
	call_correct_animation()

func call_correct_animation():
	var animation = "move_" if target_speed.length() != 0 else "idle_"
	animation = animation + dir_state
	
	#print(animation)
	$PlayerSprite.play(animation)

func check_for_attacks():
	if Input.is_action_pressed("click"):
		if $ShootTimer.time_left == 0:
			$ShootTimer.start(attack_speed)
			attack()

func attack():
	print("Attack")

func interact():
	if Input.is_action_just_pressed("interact"):
		print("trying to interact")
		if globals.in_menu == false:
			if near_pot == true:
				globals.in_cooking_menu = true
				globals.in_menu = true
				print("Player has interacted with the cooking menu")
				
				# Open the cooking menu
				$"..".cooking_menu_inst()
			elif find_interactables():
				
				get_nearest_interactable().player_interact()
			else:
				print("Failed to interact with anything")
	
	if Input.is_action_just_pressed("inventory"):
		globals.in_inventory = !globals.in_inventory

func check_hotbar_focus():
	for num in range(10):
		if Input.is_key_pressed(48 + num):
			$Hotbar.slot_focused = num
