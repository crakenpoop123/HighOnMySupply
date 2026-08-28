extends Node2D
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.scene = "store"

	$Tilemaps/Collisions.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
