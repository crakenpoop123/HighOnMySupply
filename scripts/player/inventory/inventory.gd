extends Control

var item_setup = preload("res://scenes/player/inventory/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in Globals.inventory_items:
		var curr_item = item_setup.instantiate()
		
		var accessible_item = Globals.inventory_items[item]
		
		curr_item.item_name = accessible_item["name"]
		curr_item.item_quantity = accessible_item["stock"]
		
		get_node("InventoryScroll/ScrollVBox").add_child(curr_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.visible = Globals.in_inventory
