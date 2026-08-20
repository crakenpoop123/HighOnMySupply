extends Control

var item_setup = preload("res://scenes/player/inventory/item.tscn")
var item_location = "InventoryScroll/ScrollGrid"

var viewed_items = globals.inventory_ingredients

var item_mode = "ingredients"

var dragging = null
var slot_interacted = null
var dragging_array
var slot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_items()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Only show the inventory if you are in the inventory *wow*
	$".".visible = globals.in_inventory
	
	# Show the drag sprite only if something is being dragged
	$"../DraggedSprite".visible = dragging != null
	
	# Checks for if the mouse clicked something important
	check_for_draggables()
	
	# Detect when the inventory was just closed
	if !globals.in_inventory and globals.just_in_inventory:
		dragging = null
	
	# Update globals.just_in_inventory
	globals.just_in_inventory = globals.in_inventory
	
	#print("drag_item: ", dragging)
	
	# Drag the item to a spot
	drag_item(dragging)
	snap_to_grid($"../SnapSprite")

# This updates the items in the inventory for when you change tabs or smt
func update_items():
	clear_items()
	load_items()

# This clears the old items
func clear_items():
	for child in get_node(item_location).get_children():
		child.queue_free()

# This function loads the items back
func load_items():
	check_viewed_items()
	
	# Iterates over all the items
	for item in viewed_items:
		# Instantiate the item
		var curr_item = item_setup.instantiate()
		
		# This stores the current items index in the item arrays
		var accessible_item = viewed_items[item]
		
		# Init stuff about the item
		curr_item.item_index = item
		curr_item.item_name = accessible_item["name"]
		curr_item.item_quantity = accessible_item["stock"]
		curr_item.icon = accessible_item["icon_region"]
		
		get_node(item_location).add_child(curr_item)

# Check which tab is open
func check_viewed_items():
	if item_mode == "ingredients":
		viewed_items = globals.inventory_ingredients
	elif item_mode == "buildings":
		viewed_items = globals.inventory_buildings
	else:
		push_error("item_mode is an incorrect value. It is currently set to", item_mode)

# Checks for if the mouse clicked something important
func check_for_draggables():
	# Check if click is pressed
	if Input.is_action_just_pressed("click"):
		# Check if the items were pressed
		for item in $InventoryScroll/ScrollGrid.get_children():
			if item.mouse_touching:
				# Save the item that should be dragged
				dragging = item.item_index
				# A slot is no longer being interacted
				slot_interacted = null
				print(dragging)
				return
		
		
		# Check if a hotbar slot was pressed
		for slot in $"../../Hotbar/HotbarGrid".get_children():
			if slot.mouse_touching:
				# Slot_interacted is set to the respective slot
				slot_interacted = slot.label
				print(slot_interacted)
				return
		
		# If nothing was interacted with, set both to null
		dragging = null
		slot_interacted = null

# This gets the item node corresponding with the item's name
func get_item_node_from_name(name):
	# Iterate over all item nodes
	for item in $InventoryScroll/ScrollGrid.get_children():
		# Check if the name is correct
		if item.item_name == name:
			return item
	
	# Return null if no item was found
	return null

# This gets the slot node corresponding with the item's name
func get_slot_node_from_name(slot_label):
	# Iterate over all item nodes
	for slot in $"../../Hotbar/HotbarGrid".get_children():
		# Check if the name is correct
		if slot.label == str(slot_label):
			return slot
	
	# Return null if no item was found
	return null

# Snap a node to the grid
func snap_to_grid(movable):
	movable.global_position = floor(get_global_mouse_position() / globals.grid_size) * globals.grid_size
	#print(movable.global_position)

# Drag the item to a spot
func drag_item(dragged_item):
	
	# Get the correct item array
	if dragged_item in globals.inventory_ingredients:
		dragging_array = globals.inventory_ingredients
	elif dragged_item in globals.inventory_buildings:
		dragging_array = globals.inventory_buildings
	
	# Move the drag sprite to the mouse
	$"../DraggedSprite".global_position = get_global_mouse_position()
	# Update the drag sprites texture
	$"../DraggedSprite".texture = dragging_array[dragged_item]["icon_region"] if dragging else null
	
	# If a slot was interacted
	if slot_interacted:
		print("dragging in slot_interacted if statement: ", dragging)
		
		# Get the correct slot
		slot = get_slot_node_from_name(slot_interacted)
		
		
		# If there was already an item being dragged, move that item to the slot
		if dragging:
			# Add the dragged item to the slot
			slot.item = dragged_item
			print("dragged_item in slot: ", dragged_item)
			# Show the item's icon in the slot
			slot.item_icon = dragging_array[dragged_item]["icon_region"]
			# Set the slot to te correct type
			slot.item_type = "building" if dragging_array == globals.inventory_buildings else "ingredients"
			
			# Stop dragging the item
			dragging = null
			slot_interacted = null
		else:
			# Start dragging the item in the slot
			dragging = slot.item
			print("item in slot: ", dragging)
			
			# This fixes a bug where it instantly tries to place the item back in the slot
			slot_interacted = null
			
			# If you are in the inventory, the item can be removed from the slot
			if globals.in_inventory:
				slot.item = null
				slot.item_type = null
				slot.item_icon = null





# Switch the tab to buildings
func _on_buildings_tab_pressed() -> void:
	item_mode = "buildings"
	update_items()

# Switch the tab to ingredients
func _on_ingredients_tab_pressed() -> void:
	item_mode = "ingredients"
	update_items()

# Close the inventory with the button
func _on_close_inventory_pressed() -> void:
	globals.in_inventory = false
