extends Control

var item_setup = preload("res://scenes/player/inventory/item.tscn")
var item_location = "InventoryScroll/ScrollGrid"

var viewed_items = globals.inventory_ingredients

var item_mode = "ingredients"

var dragging = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_items()

func update_items():
	clear_items()
	load_items()

func clear_items():
	for child in get_node(item_location).get_children():
		child.queue_free()

func check_viewed_items():
	if item_mode == "ingredients":
		viewed_items = globals.inventory_ingredients
	elif item_mode == "buildings":
		viewed_items = globals.inventory_buildings
	else:
		push_error("item_mode is an incorrect value. It is currently set to", item_mode)

func load_items():
	check_viewed_items()
	
	for item in viewed_items:
		var curr_item = item_setup.instantiate()
		
		var accessible_item = viewed_items[item]
		
		curr_item.item_name = accessible_item["name"]
		curr_item.item_quantity = accessible_item["stock"]
		curr_item.icon = accessible_item["icon_region"]
		
		get_node(item_location).add_child(curr_item)

func check_for_draggables():
	for item in $InventoryScroll/ScrollGrid.get_children():
		if item.mouse_touching:
			dragging = item.name
			print(dragging)
			return
		dragging = null

func get_node_from_name(name):
	for item in $InventoryScroll/ScrollGrid.get_children():
		if item.item_name == name:
			return item
	return null

func drag_item(dragged_item):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.visible = globals.in_inventory
	if globals.in_inventory:
		check_for_draggables()
		if dragging:
			drag_item(get_node_from_name(dragging))

func _on_buildings_tab_pressed() -> void:
	item_mode = "buildings"
	update_items()


func _on_ingredients_tab_pressed() -> void:
	item_mode = "ingredients"
	update_items()


func _on_close_inventory_pressed() -> void:
	globals.in_inventory = false
