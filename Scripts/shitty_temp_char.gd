extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("interact"):
		if near_pot == true:
			print("interacting")
		else:
			print("failed to interact")
func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
