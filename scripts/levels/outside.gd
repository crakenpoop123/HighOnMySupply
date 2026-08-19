extends Node2D
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Tilemaps/Collisions.hide()
	$"Tilemaps/Bottom Layer/Buildings".modulate.a = 100
	$"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a = 100
	
	$"Tilemaps/Second Layer/Buildings2".modulate.a = 100
	$"Tilemaps/Second Layer/Buildings2 Bottom".modulate.a = 100
	
	$"Tilemaps/Third Layer/Buildings3".modulate.a = 100
	$"Tilemaps/Third Layer/Buildings3 Bottom".modulate.a = 100
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.global_position.y)
	if player.global_position.y < -465:
		$"Tilemaps/Bottom Layer/Buildings".modulate.a = 0
		$"Tilemaps/Bottom Layer/Buildings Bottom".modulate.a = 0
