extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

func _process(_delta: float) -> void:
	if Globals.in_menu == true:
		Globals.can_move = false
		velocity.x = 0
	else:
		Globals.can_move = true
		
	if Input.is_action_just_pressed("interact"):
		print("trying to interact")
		if Globals.in_menu == false:
			if near_pot == true:
				Globals.in_cooking_menu = true
				Globals.in_menu = true
				print("in cooking menu")
				$"..".cooking_menu_inst()
			else:
				print("failed to interact with anything")
		
func _physics_process(_delta: float) -> void:
	if Globals.can_move == true:
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_area_2d_body_entered(_body: Node2D) -> void:
	near_pot = true
	print(near_pot)

func _on_area_2d_body_exited(_body: Node2D) -> void:
	near_pot = false
	print(near_pot)
