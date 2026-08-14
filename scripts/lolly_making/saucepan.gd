extends Node2D
var in_cooking_scene = false
var on_oven = false
var size = 32

func _process(_delta: float) -> void:
	if in_cooking_scene == true:
		$SaucepanSprite.texture.region = Rect2(32, 0, size, size*2)


func _on_saucepan_area_body_entered(body: StaticBody2D) -> void:
	if body.name == "StoveBody":
		on_oven = true

func _on_saucepan_area_body_exited(body: StaticBody2D) -> void:
	if body.name == "StoveBody":
		on_oven = false
