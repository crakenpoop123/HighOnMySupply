extends Node2D
var in_cooking_scene = false
var on_oven = false
var on_table = false
var on_mold = false
var size = 32
	
func _ready() -> void:
	$SaucepanSprite.texture.region = Rect2(32, 0, size, size*2) # SET THE AREA OF THE ATLAS TEXTURE
	if in_cooking_scene == true:
		$SaucepanSprite.texture = load("res://assets/full-saucepan-spritesheet.png") # WHAT?
		
func _on_saucepan_area_body_entered(body: StaticBody2D) -> void: # DETECT WHEN ENTERING AREAS
	if body.name == "StoveBody":
		on_oven = true
	if body.name == "TableBody":
		on_table = true
	if body.name == "MoldBody":
		on_mold = true
		$"../Mold".change_sprite()
		
func _on_saucepan_area_body_exited(body: StaticBody2D) -> void: # DETECT WHEN EXITING AREAS
	if body.name == "StoveBody":
		on_oven = false
	if body.name == "TableBody":
		on_table = false
	if body.name == "MoldBody":
		on_mold = false
		
func empty(): # MAKE THE SAUCEPAN SPRITE EMPTY
	$SaucepanSprite.texture = load("res://assets/misc/saucepan.png")
