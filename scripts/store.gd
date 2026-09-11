extends Node2D
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.scene = "store"

	$Tilemaps/Collisions.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if globals.fading == true:
		# print($Player.global_position.y)
		# Make the bottom layer fade out as you move upwards
		if $Player.global_position.y < 76:
			if $Tilemaps/ShelvesOne/ShelvesOneTop.modulate.a > 0.2:
				$Tilemaps/ShelvesOne/ShelvesOneTop.modulate.a -= 0.03
				
			if $Tilemaps/ShelvesOne/ShelvesOneBottom.modulate.a > 0.2:
				$Tilemaps/ShelvesOne/ShelvesOneBottom.modulate.a -= 0.03
				
		else:
			if $Tilemaps/ShelvesOne/ShelvesOneTop.modulate.a < 1:
				$Tilemaps/ShelvesOne/ShelvesOneTop.modulate.a += 0.03
				
			if $Tilemaps/ShelvesOne/ShelvesOneBottom.modulate.a < 1:
				$Tilemaps/ShelvesOne/ShelvesOneBottom.modulate.a += 0.03
		
		# Make the second layer fade out as you move upwards
		if $Player.global_position.y < -84:
			if $Tilemaps/ShelvesTwo/ShelvesTwoTop.modulate.a > 0.2:
				$Tilemaps/ShelvesTwo/ShelvesTwoTop.modulate.a -= 0.03
				
			if $Tilemaps/ShelvesTwo/ShelvesTwoBottom.modulate.a > 0.2:
				$Tilemaps/ShelvesTwo/ShelvesTwoBottom.modulate.a -= 0.03
				
		else:
			if $Tilemaps/ShelvesTwo/ShelvesTwoTop.modulate.a < 1:
				$Tilemaps/ShelvesTwo/ShelvesTwoTop.modulate.a += 0.03
				
			if $Tilemaps/ShelvesTwo/ShelvesTwoBottom.modulate.a < 1:
				$Tilemaps/ShelvesTwo/ShelvesTwoBottom.modulate.a += 0.03

		# Make the third layer fade out as you move upwards
		if $Player.global_position.y < -244:
			if $Tilemaps/ShelvesThree/ShelvesThreeTop.modulate.a > 0.2:
				$Tilemaps/ShelvesThree/ShelvesThreeTop.modulate.a -= 0.03
				
			if $Tilemaps/ShelvesThree/ShelvesThreeBottom.modulate.a > 0.2:
				$Tilemaps/ShelvesThree/ShelvesThreeBottom.modulate.a -= 0.03
				
		else:
			if $Tilemaps/ShelvesThree/ShelvesThreeTop.modulate.a < 1:
				$Tilemaps/ShelvesThree/ShelvesThreeTop.modulate.a += 0.03
				
			if $Tilemaps/ShelvesThree/ShelvesThreeBottom.modulate.a < 1:
				$Tilemaps/ShelvesThree/ShelvesThreeBottom.modulate.a += 0.03
				
		# Make the fourth layer fade out as you move upwards
		if $Player.global_position.y < -404:
			if $Tilemaps/ShelvesFour/ShelvesFourTop.modulate.a > 0.2:
				$Tilemaps/ShelvesFour/ShelvesFourTop.modulate.a -= 0.03
				
			if $Tilemaps/ShelvesFour/ShelvesFourBottom.modulate.a > 0.2:
				$Tilemaps/ShelvesFour/ShelvesFourBottom.modulate.a -= 0.03
				
		else:
			if $Tilemaps/ShelvesFour/ShelvesFourTop.modulate.a < 1:
				$Tilemaps/ShelvesFour/ShelvesFourTop.modulate.a += 0.03
				
			if $Tilemaps/ShelvesFour/ShelvesFourBottom.modulate.a < 1:
				$Tilemaps/ShelvesFour/ShelvesFourBottom.modulate.a += 0.03
