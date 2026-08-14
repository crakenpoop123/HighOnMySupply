extends Node2D

var inside_pot = false
var dropped_into_pot = false
var size = 32

func _process(delta: float) -> void:
	if dropped_into_pot == true:
		$IngrediantSprite.texture.region = Rect2(64, 0, size, size)

func _on_ingrediant_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "SaucepanArea":
		inside_pot = true

func _on_ingrediant_area_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "SaucepanArea":
		inside_pot = false
