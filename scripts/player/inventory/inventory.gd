extends Control

var item_setup = preload("res://scenes/player/inventory/item.tscn")
var item_location = "InventoryScroll/ScrollGrid"

var viewed_items = globals.inventory_ingredients

var item_mode = "ingredients"

var dragging = null
var slot_interacted = null
var dragging_type = null
var dragging_array
var placing = false
var slot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_items()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Only show the inventory if you are in the inventory *wow*
	$".".visible = globals.in_inventory
	
	# Show the snap sprite sprite only if something is being dragged that should be snapped
	if !dragging:
		$"../../SnapSprite".texture = null
	$"../../SnapSprite".visible = placing != null and $"../../SnapSprite".texture != null
	# Show the drag sprite sprite only if something is being dragged
	$"../DraggedSprite".visible = dragging != null and !$"../../SnapSprite".visible
	
	# Checks for if the mouse clicked something important
	#print(check_for_draggables())
	check_for_draggables()
	#print("placing: ", placing)
	
	#print("placing: ", placing)
	
	# Detect when the inventory was just closed
	if !globals.in_inventory and globals.just_in_inventory:
		dragging = null
	
	# Update globals.just_in_inventory
	globals.just_in_inventory = globals.in_inventory
	
	# Drag the item to a spot
	drag_item()
	if globals.scene == "basement":
		snap_to_grid($"../../SnapSprite")

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
	# Save placing's state
	var init_placing = placing
	# Set placing to false
	placing = false
	
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
				return "item"
		
		
		# Check if a hotbar slot was pressed
		for item_slot in $"../../Hotbar/HotbarGrid".get_children():
			if item_slot.mouse_touching:
				# Slot_interacted is set to the respective slot
				slot_interacted = item_slot.label
				print(slot_interacted)
				return "slot"
		
		placing = $"../../SnapSprite".visible
		
		# Used to instantiate a building when brought out of the hotbar
		if placing:
			if !check_overlapping_buildings():
				if globals.inventory_buildings[dragging]["stock"] != 0:
					instantiate_building(dragging, $"../../SnapSprite".global_position)
					print("Place")
					return "Place"
				else:
					print("No stock to place")
					return "No stock"
			else:
				print("Obstructed tile")
				return "Obstruction"
		# Set placing back to what it previously was
		placing = init_placing
		
		
		# If nothing was interacted with, set both to null
		dragging = null
		slot_interacted = null
		print("Interacted with nothing")
		return null

# Instantiate a building *shocker*
func instantiate_building(building, global_pos):
	print("Instantiate building at pos: ", global_pos)
	
	# Offset to get the building to the correct position = to negative half the screens width and height
	var building_offset = Vector2.ZERO
	#Vector2(-576, -324)
	
	var built_struct = globals.inventory_buildings[building]["scene"].instantiate()
	
	built_struct.global_position = global_pos + building_offset
	print("built struct at pos: ", built_struct.global_position)
	
	$"../../../Buildables".add_child(built_struct)
	
	# Get rid of the snapSprite
	$"../../SnapSprite".texture = null
	dragging = null
	# Remove the building from the inventory
	globals.inventory_buildings[building]["stock"] -= 1

# Check if there are any buildings in the spot that a new building is trying to be placed
func check_overlapping_buildings():
	
	#Get the global list of names of interactable bodies and loop through each name
	for building_parent in globals.interactable_parents:
		# Checks that the basement has the body
		if $"../../..".has_node(building_parent):
			# Loops through all children of the current body
			for child in $"../../..".get_node(building_parent).get_children():
				# If the current child is in the bodies overlapping with $"../../SnapSprite/CollisionArea", print it
				if child in $"../../SnapSprite/CollisionArea".get_overlapping_bodies():
					return true
	
	return false

# This gets the item node corresponding with the item's name
func get_item_node_from_name(item_name):
	# Iterate over all item nodes
	for item in $InventoryScroll/ScrollGrid.get_children():
		# Check if the name is correct
		if item.item_name == item_name:
			return item
	
	# Return null if no item was found
	return null

# This gets the slot node corresponding with the item's name
func get_slot_node_from_name(slot_label):
	# Iterate over all item nodes
	for slot_item in $"../../Hotbar/HotbarGrid".get_children():
		# Check if the name is correct
		if slot_item.label == str(slot_label):
			return slot_item
	
	# Return null if no item was found
	return null

# Snap a node to the grid
func snap_to_grid(movable):
	#print("player pos: ", $"../..".position)
	#print("global mouse pos: ", get_global_mouse_position())
	var floor_offset = Vector2(fposmod($"../../../Floor".global_position[0], float(globals.grid_size)), fposmod($"../../../Table".global_position[1], float(globals.grid_size)))
	#print("floor_offset: ", floor_offset)
	# Lock position to the grid
	movable.position = floor((get_global_mouse_position() - get_viewport_rect().size/2 + $"../..".global_position + floor_offset - Vector2(1, -19)) / globals.grid_size + Vector2(0.5, 0.5)) * globals.grid_size
	# Re-adjust to the correct spot
	movable.position = movable.position - $"../..".global_position - floor_offset + Vector2(11, -19)
	#print("movable snapped global pos: ", movable.global_position)
	#print("movable corrected pos: ", movable.position)

# Drag the item to a spot
func drag_item():
	#print("dragging: ", dragging)
	
	# Get the correct item array
	if dragging in globals.inventory_ingredients:
		dragging_array = globals.inventory_ingredients
	elif dragging in globals.inventory_buildings:
		dragging_array = globals.inventory_buildings
	
	# Move the drag sprite to the mouse
	$"../DraggedSprite".global_position = get_global_mouse_position()
	# Update the drag sprites texture
	$"../DraggedSprite".texture = dragging_array[dragging]["icon_region"] if dragging else null
	
	# If a slot was interacted
	if slot_interacted:
		#print("dragging in slot_interacted if statement: ", dragging)
		
		# Get the correct slot
		slot = get_slot_node_from_name(slot_interacted)
		
		
		# If there was already an item being dragged, move that item to the slot
		if dragging:
			# Add the dragged item to the slot
			slot.item = dragging
			#print("dragging in slot: ", dragging)
			# Show the item's icon in the slot
			slot.item_icon = dragging_array[dragging]["icon_region"]
			# Set the slot to te correct type
			slot.item_type = "building" if dragging_array == globals.inventory_buildings else "ingredients"
			
			# Stop dragging the item
			dragging = null
			slot_interacted = null
		else:
			# Start dragging the item in the slot
			dragging = slot.item
			#print("item in slot: ", dragging, " | item_type: ", slot.item_type)
			
			
			if slot.item_type == "building":
				$"../../SnapSprite".texture = slot.item_icon
				placing = true
				print("placing true")
			
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
