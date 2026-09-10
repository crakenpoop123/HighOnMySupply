extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.scene = "basement"
	globals.can_drag = true
	#$Collisions.hide() # TODO: What is this?


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
