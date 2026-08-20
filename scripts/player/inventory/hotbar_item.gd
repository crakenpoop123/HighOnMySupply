extends TextureRect

# Variables
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
	# Set the text
	$ItemQuantity.text = label
	
	# Show the item icon
	$SlotItem.visible = item_icon != null
	
	# Set the icon's texture
	if item_icon:
		$SlotItem.texture = item_icon


# Detect when the mouse touches the slot
func _on_slot_area_mouse_entered() -> void:
	mouse_touching = true

# Detect when the mosue stops touching the slot
func _on_slot_area_mouse_exited() -> void:
	mouse_touching = false
