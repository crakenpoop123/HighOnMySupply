extends Node2D
@export var player: Node2D

func _ready() -> void:
	globals.scene = "outside"
	# print("Loading point: ", globals.player_loading_point)
	# print("Player is loaded as: ", player)
	if globals.player_loading_point == "basement":
		player.global_position = Vector2(2198.0, -491)
	elif globals.player_loading_point == "store":
		player.global_position = Vector2(-280, -491)
		
	$Tilemaps/Tilemaps/Collisions.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(player.global_position.y)
	# Make the bottom layer fade out as you move upwards
	if player.global_position.y < -700:
		if $"Tilemaps/Tilemaps/Bottom Layer/Buildings".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Bottom Layer/Buildings".modulate.a -= 0.03
			
		if $"Tilemaps/Tilemaps/Bottom Layer/Buildings Bottom".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Bottom Layer/Buildings Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Tilemaps/Bottom Layer/Buildings".modulate.a < 1:
			$"Tilemaps/Tilemaps/Bottom Layer/Buildings".modulate.a += 0.03
			
		if $"Tilemaps/Tilemaps/Bottom Layer/Buildings Bottom".modulate.a < 1:
			$"Tilemaps/Tilemaps/Bottom Layer/Buildings Bottom".modulate.a += 0.03
	
	# Make the second layer fade out as you move upwards
	if player.global_position.y < -1024:
		if $"Tilemaps/Tilemaps/Second Layer/Buildings2".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Second Layer/Buildings2".modulate.a -= 0.03
			
		if $"Tilemaps/Tilemaps/Second Layer/Buildings2 Bottom".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Second Layer/Buildings2 Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Tilemaps/Second Layer/Buildings2".modulate.a < 1:
			$"Tilemaps/Tilemaps/Second Layer/Buildings2".modulate.a += 0.03
			
		if $"Tilemaps/Tilemaps/Second Layer/Buildings2 Bottom".modulate.a < 1:
			$"Tilemaps/Tilemaps/Second Layer/Buildings2 Bottom".modulate.a += 0.03
	
	# Make the third layer fade out as you move upwards
	if player.global_position.y < -1584:
		if $"Tilemaps/Tilemaps/Third Layer/Buildings3".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Third Layer/Buildings3".modulate.a -= 0.03
			
		if $"Tilemaps/Tilemaps/Third Layer/Buildings3 Bottom".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Third Layer/Buildings3 Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Tilemaps/Third Layer/Buildings3".modulate.a < 1:
			$"Tilemaps/Tilemaps/Third Layer/Buildings3".modulate.a += 0.03
			
		if $"Tilemaps/Tilemaps/Third Layer/Buildings3 Bottom".modulate.a < 1:
			$"Tilemaps/Tilemaps/Third Layer/Buildings3 Bottom".modulate.a += 0.03
			
	# Make the fourth layer fade out as you move upwards
	if player.global_position.y < -2464:
		if $"Tilemaps/Tilemaps/Fourth Layer/Buildings4".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Fourth Layer/Buildings4".modulate.a -= 0.03
			
		if $"Tilemaps/Tilemaps/Fourth Layer/Buildings4 Bottom".modulate.a > 0.2:
			$"Tilemaps/Tilemaps/Fourth Layer/Buildings4 Bottom".modulate.a -= 0.03
			
	else:
		if $"Tilemaps/Tilemaps/Fourth Layer/Buildings4".modulate.a < 1:
			$"Tilemaps/Tilemaps/Fourth Layer/Buildings4".modulate.a += 0.03
			
		if $"Tilemaps/Tilemaps/Fourth Layer/Buildings4 Bottom".modulate.a < 1:
			$"Tilemaps/Tilemaps/Fourth Layer/Buildings4 Bottom".modulate.a += 0.03
