extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

var target_speed = Vector2.ZERO
var movement_smoothing = 5

var attack_speed = 2 # interval(secs) between attacks
var player_dir = 0
# Init the player to be facing towards the screen
var dir_state = "down"

var slot_focused = 0

func _ready():
	# Hide the GUI Error
	# This is used to display an error to the player, like insufficient ingredients
	$GUIError.visible = false

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

# Display an error message on the screen that the user can see
func display_gui_error(error, duration = 2):
	# Update the text and show the text label
	$GUIError.text = error
	$GUIError.visible = true
	
	# Start a timer to hide the error after a period of time
	$GUIError/ErrorTimer.start(duration)

# When the error timer runs out
func _on_error_timer_timeout() -> void:
	# Hide the error text
	$GUIError.visible = false


func find_interactables():
	#print(globals.interactable_parents)
	for interactable_parent in globals.interactable_parents:
		#print(interactable_parent)
			
		if $"..".has_node(interactable_parent):
			for interactable in $"..".get_node(interactable_parent).get_children():
				if is_interact_area_touching(interactable):
					return true
	return false

func get_nearest_interactable():
	#print("Getting nearest parent")
	
	# Init the closest dist to infinity so all interactables will be closer than that
	var closest_dist = INF
	var closest_interactable
	
	# Iterate over all interactable parents
	for interactable_parent in globals.interactable_parents:
		# Check if this parent exists
		if $"..".has_node(interactable_parent):
			# Iterate through all interactables (children of the interactable parents)
			for interactable in $"..".get_node(interactable_parent).get_children():
				# Set the curr_dist to the dist between the player and the interactable
				var curr_dist = self.global_position.distance_to(interactable.global_position)
				
				# If this interactable is touching the player's interact area and it is closer than the current closest interactable
				if is_interact_area_touching(interactable) and curr_dist < closest_dist:
					# Update the closes dist and interactable
					closest_dist = curr_dist
					closest_interactable = interactable
	
	# Return the closest interactable
	# Will return null if none were found
	return closest_interactable

# Function to check if a body is within the player's interact radius
func is_interact_area_touching(body):
	# Checks if body is overlapping with $InteractArea
	return body in $InteractArea.get_overlapping_bodies()

func move():
	target_speed = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		target_speed[1] += -SPEED
	if Input.is_action_pressed("move_down"):
		target_speed[1] += SPEED
		
	if Input.is_action_pressed("move_left"):
		target_speed[0] += -SPEED
	if Input.is_action_pressed("move_right"):
		target_speed[0] += SPEED
	
	
	

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
	pass
	#print("Attack")

func interact():
	if Input.is_action_just_pressed("interact"):
		#print("trying to interact")
		if globals.in_menu == false:
			if find_interactables():
				# Interact with the nearest interactable object and save the result
				var interact_result = get_nearest_interactable().player_interact()
				if interact_result != null:
					display_gui_error("Insufficient stock of " + interact_result + ". You need at least 1 " + interact_result)
			else:
				pass
			#	print("Failed to interact with anything")
	
	if Input.is_action_just_pressed("inventory"):
		globals.in_inventory = !globals.in_inventory

func check_hotbar_focus():
	for num in range(10):
		if Input.is_key_pressed(48 + num):
			$Hotbar.slot_focused = num
	if !globals.in_inventory:
		if Input.is_action_just_pressed("scroll_up"):
			$Hotbar.slot_focused += 1
		if Input.is_action_just_pressed("scroll_down"):
			$Hotbar.slot_focused -= 1
	
	$Hotbar.slot_focused = ($Hotbar.slot_focused - 1) % 9 + 1
	if $Hotbar.slot_focused <= 0:
		$Hotbar.slot_focused += 9
	
	#print($Hotbar.slot_focused)
