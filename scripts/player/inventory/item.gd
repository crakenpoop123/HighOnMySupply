extends TextureRect

var item_name: String = "Hi, I'm an item"
var item_quantity = 0
var icon
var mouse_touching = false
var item_index: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ItemName.text = item_name
	$ItemQuantity.text = "Quantity: " + str(item_quantity)
	$ItemIcon.texture = icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ItemQuantity.text = "Quantity: " + str(item_quantity)


func _on_interact_area_mouse_entered() -> void:
	mouse_touching = true
	print("touching ", item_name)


func _on_interact_area_mouse_exited() -> void:
	mouse_touching = false
