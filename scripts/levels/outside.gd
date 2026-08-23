extends Node2D
@export var player: Node2D

func _ready() -> void:
	globals.scene = "outside"
	
	$Tilemaps/Collisions.hide()
	$"Tilemaps/Bottom Layer/Buildings".modulate.a = 1
	$"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a = 1
	
	$"Tilemaps/Second Layer/Buildings2".modulate.a = 1
	$"Tilemaps/Second Layer/Buildings2 Bottom".modulate.a = 1
	
	$"Tilemaps/Third Layer/Buildings3".modulate.a = 1
	$"Tilemaps/Third Layer/Buildings3 Bottom".modulate.a = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.global_position.y)
	
	# Make the bottom layer fade out as you move upwards
	if player.global_position.y < -700:
		if $"Tilemaps/Bottom Layer/Buildings".modulate.a > 0.2:
			$"Tilemaps/Bottom Layer/Buildings".modulate.a -= 0.03
			
		if $"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a > 0.2:
			$"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Bottom Layer/Buildings".modulate.a < 1:
			$"Tilemaps/Bottom Layer/Buildings".modulate.a += 0.03
			
		if $"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a < 1:
			$"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a += 0.03
	
	# Make the second layer fade out as you move upwards
	if player.global_position.y < -1024:
		if $"Tilemaps/Second Layer/Buildings2".modulate.a > 0.2:
			$"Tilemaps/Second Layer/Buildings2".modulate.a -= 0.03
			
		if $"Tilemaps/Second Layer/Buildings2 Bottom".modulate.a > 0.2:
			$"Tilemaps/Second Layer/Buildings2 Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Second Layer/Buildings2".modulate.a < 1:
			$"Tilemaps/Second Layer/Buildings2".modulate.a += 0.03
			
		if $"Tilemaps/Second Layer/Buildings2 Bottom".modulate.a < 1:
			$"Tilemaps/Second Layer/Buildings2 Bottom".modulate.a += 0.03
	
	# Make the third layer fade out as you move upwards
	if player.global_position.y < -1584:
		if $"Tilemaps/Third Layer/Buildings3".modulate.a > 0.2:
			$"Tilemaps/Third Layer/Buildings3".modulate.a -= 0.03
			
		if $"Tilemaps/Third Layer/Buildings3 Bottom".modulate.a > 0.2:
			$"Tilemaps/Third Layer/Buildings3 Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Third Layer/Buildings3".modulate.a < 1:
			$"Tilemaps/Third Layer/Buildings3".modulate.a += 0.03
			
		if $"Tilemaps/Third Layer/Buildings3 Bottom".modulate.a < 1:
			$"Tilemaps/Third Layer/Buildings3 Bottom".modulate.a += 0.03
