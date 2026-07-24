extends CharacterBody2D

var near_pot: bool = false
var in_pot_menu = false
var in_menu = false
var can_move = true

const SPEED = 300.0

func _process(_delta: float) -> void:
	if in_menu == true:
		can_move = false
	else:
		can_move = true
	if Input.is_action_just_pressed("interact"):
		if in_pot_menu == false:
			print("interacting")
			if near_pot == true:
				in_pot_menu = true
				in_menu = true
		elif in_pot_menu == true:
			in_pot_menu = false
			in_menu = false
		else:
			print("failed to interact")
		
func _physics_process(_delta: float) -> void:
	if can_move == true:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	near_pot = true
	print(near_pot)

func _on_area_2d_body_exited(body: Node2D) -> void:
	near_pot = false
	print(near_pot)
