extends Node2D

var on_oven = false

func _on_ingrediant_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.parent.name == "Stove":
		on_oven = true

func _on_ingrediant_area_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.parent.name == "Stove":
		on_oven = false
