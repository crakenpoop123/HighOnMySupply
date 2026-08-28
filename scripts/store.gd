extends Node2D
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.scene = "store"

	$Tilemaps/Collisions.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
