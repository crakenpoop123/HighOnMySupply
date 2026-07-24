extends CharacterBody2D

var near_pot: bool = false
var in_menu = false

const SPEED = 300.0

func _process(_delta: float) -> void:
	if in_menu == true:
		Globals.can_move = false
		velocity.x = 0
	else:
		Globals.can_move = true
		
	if Input.is_action_just_pressed("interact"):
		print("trying to interact")
		if near_pot == true:
			Globals.in_cooking_menu = !Globals.in_cooking_menu
			in_menu = Globals.in_cooking_menu # I'm sure there is probably issues with this line and the whole thing but oh well
			print("in cooking menu")
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
