extends Node2D
var base_image

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_sprite():
	base_image = load("res://assets/silicon-mold.png")
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = base_image
	atlas_texture.region = Rect2(64, 0, 32, 32)
	$SiliconMold.texture = atlas_texture
	$"../Saucepan".empty()
