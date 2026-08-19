extends Node2D

var inside_pot = false
var dropped_into_pot = false
var size = 32

func _process(_delta: float) -> void:
	if dropped_into_pot == true: # WHEN IT IS IN THE SAUCEPAN
		$IngrediantSprite.texture.region = Rect2(64, 0, size, size) # CHANGE TO SPRITE WITHOUT BAG

func _on_ingrediant_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "SaucepanArea": # IF IT IS IN THE SAUCEPAN
		inside_pot = true # I AM IN THE SAUCEPAN

func _on_ingrediant_area_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "SaucepanArea": # IF IT IS NOT IN THE SAUCEPAN
		inside_pot = false # I AM NOT IN THE SAUCEPAN
