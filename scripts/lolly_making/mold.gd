extends Node2D
var base_image


func change_sprite(): # CHANGE SPRITE TO BLUE WHEN FILLED UP
	base_image = load("res://assets/silicon-mold.png")
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = base_image
	atlas_texture.region = Rect2(64, 0, 32, 32)
	$SiliconMold.texture = atlas_texture
	$"../Saucepan".empty()
