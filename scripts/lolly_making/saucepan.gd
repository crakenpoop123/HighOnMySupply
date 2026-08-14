extends Node2D

var on_oven = false

func _on_saucepan_area_body_entered(body: StaticBody2D) -> void:
	if body.name == "StoveBody":
		on_oven = true

func _on_saucepan_area_body_exited(body: StaticBody2D) -> void:
	if body.name == "StoveBody":
		on_oven = false
