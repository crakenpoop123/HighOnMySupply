extends Node2D

var inside_shredder = false
var dropped_into_shredder = false
var size = 32

func _on_sugarcane_area_body_entered(body: Node2D) -> void:
	if body.name == "ShredderBody":
		inside_shredder = true

func _on_sugarcane_area_body_exited(body: Node2D) -> void:
	if body.name == "ShredderBody":
		inside_shredder = false
