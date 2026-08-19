extends TextureRect

var label = "0"
var mouse_touching = false
var item_icon = null
var item_type = null
var item = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ItemQuantity.text = label
	$SlotItem.visible = item_icon != null
	if item_icon:
		$SlotItem.texture = item_icon


func _on_slot_area_mouse_entered() -> void:
	mouse_touching = true


func _on_slot_area_mouse_exited() -> void:
	mouse_touching = false
