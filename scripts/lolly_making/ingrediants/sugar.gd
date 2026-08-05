extends Node2D

var inside_pot = false
@onready var mouse = $"../Mouse"

func _on_ingrediant_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "SaucepanArea":
		inside_pot = true

func _on_ingrediant_area_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "SaucepanArea":
		inside_pot = false
