extends CharacterBody2D

# Preload the audio resources
const INVENTORY_SOUND = preload("res://assets/sfx/InventorySound.mp3")
const PAUSE_SOUND = preload("res://assets/sfx/PauseSound.mp3")
const INTERACT_SOUND = preload("res://assets/sfx/InteractSound.mp3")
const INTERACT_DENIED_SOUND = preload("res://assets/sfx/InteractDeniedSound.mp3")
var near_pot: bool = false

const SPEED = 300.0

var target_speed = Vector2.ZERO
var movement_smoothing = 5

var attack_speed = 2 # interval(secs) between attacks
var player_dir = 0
# Init the player to be facing towards the screen
var dir_state = "down"
var talking_npc = null

var slot_focused = 0

func _ready():
	# Hide the GUI Error
	# This is used to display an error to the player, like insufficient ingredients
	$GUIError.visible = false
	$InteractIndicator.visible = false

func _process(delta: float) -> void:
	# Slightly increase noise_level each frame
	
	
	# Used for quadratic noise scaling
	var noise_grad = 2 * globals.noise_level # Gradient of x^2
	
	# Gets the time since the last frame, normalised by the noise rate 
	var time_change = delta / globals.noise_rate
	
	# The amount to increase the noise by
	var noise_increase = max(noise_grad * time_change, time_change / globals.min_noise_rate) 
	
	# Increase noise
	globals.noise_level += noise_increase
	#print(noise_increase)
	
	# Update Money
	$MoneyText.text = str("Money: $", globals.money)
	
	if globals.in_menu or globals.in_inventory or globals.see_text or globals.game_paused:
		globals.can_move = false
	else:
		globals.can_move = true
	if globals.see_text == true:
		$TextBox.visible = true
	else:
		$TextBox.visible = false
	interact()
	check_hotbar_focus()

func talking(text: String, npc = null):
	talking_npc = npc
	
	# Sell the user gelatin
	if str(npc) == "clerk":
		# Show the choices to buy gelatin
		$TextBox.display_choices(globals.shopkeep_choice_dict)
		
		# Passing "clerk" to the textbox results in crashes
		talking_npc = null
	# Let the user sell gummy worms
	else:
		# Show the choices to buy sell gummy worms
		$TextBox.display_choices(globals.gummy_worm_choice_dict)
	
	# Show the npc text
	$TextBox.display_text(text, talking_npc)

func _physics_process(_delta: float) -> void:
	if globals.can_move == true:
		move()
		
	else: # Stop the player from drifting when they shouldn't move
		target_speed = Vector2.ZERO
	get_player_dir()
	orient_animation()
	# Normalise the speed. This ensures diagonal movement is the same speed as rectilinear motion
	target_speed = target_speed.normalized() * SPEED
	
	velocity += (target_speed - velocity) / movement_smoothing
	
	if globals.can_attack:
		check_for_attacks()
	
	if find_interactables():
		$InteractIndicator.visible = true
		$InteractText.text = str(get_nearest_interactable().readable_name)
	else:
		$InteractIndicator.visible = false
		$InteractText.text = ""
	
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
	# if globals.broken != true:
		# globals.touching = !true
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
	if globals.see_text and talking_npc:
		var npcx = talking_npc.position.x
		var npcy = talking_npc.position.y
		player_dir = atan2(npcy - position.y, npcx - position.x)
	elif target_speed.length() != 0:
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
	var animation
	if !globals.can_move:
		animation = "idle_"
	else:
		animation = "move_" if target_speed.length() != 0 else "idle_"
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
		if !globals.in_menu and !globals.game_paused:
			if find_interactables():
				# Interact with the nearest interactable object and save the result
				
				var interact_result = await get_nearest_interactable().player_interact()
				if interact_result != null:
					GlobalAudioStreamPlayer.play_sound(INTERACT_DENIED_SOUND)
					display_gui_error("Insufficient stock of " + interact_result + ". You need at least 1 " + interact_result)
				else:
					GlobalAudioStreamPlayer.play_sound(INTERACT_SOUND)
			else:
				pass
			#	print("Failed to interact with anything")
	
	if Input.is_action_just_pressed("inventory"):
		if !globals.game_paused:
			GlobalAudioStreamPlayer.play_sound(INVENTORY_SOUND)
			globals.in_inventory = !globals.in_inventory
			$Inventory/Inventory.update_items()
		
	if Input.is_action_just_pressed("pause"):
		GlobalAudioStreamPlayer.play_sound(PAUSE_SOUND)
		globals.game_paused = !globals.game_paused

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

var min_gummy_decrease = -5
var max_gummy_increase = 7

func _on_economy_price_money_timeout() -> void:
	change_gummy_value()
	
func change_gummy_value():
	var change = randi_range(min_gummy_decrease, max_gummy_increase) # Picks a random value to increase or decrease it by
	var current = globals.gummy_worm_sell_price # Gets the current value
	current += change # Changes the current value by the change
	if current < 1: # Checks if 0 or negative
		print(current, "current is less than 1")
		#change_gummy_value() # Redo script if it is below 1
	globals.gummy_worm_sell_price = current # Add the changes
	print(globals.gummy_worm_sell_price)
