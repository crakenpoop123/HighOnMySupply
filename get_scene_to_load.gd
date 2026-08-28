extends Node2D
@export var scene_to_load: String = ""
@export var scene_from: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.player_loading_point = scene_from


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
