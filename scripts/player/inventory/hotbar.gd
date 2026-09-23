extends Control

@onready var item = preload("res://scenes/player/inventory/hotbar_item.tscn")
var num_slots = 9

var slot_focused = 1

var opacity = 0.75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initiate all of the slots
	for slot in range(num_slots):
		var curr_item = item.instantiate()
		
		$HotbarGrid.add_child(curr_item)
	
	# Iniate the slot labels
	initiate_slots()
	
	# Place all the buildings into the hotbar by default
	autoload_buildings()

# Places all buildings in the hotbar by default
func autoload_buildings():
	var building_count = 0
	for building in globals.inventory_buildings.keys():
		# Used to index the slot
		building_count += 1
		
		var slot = get_slot_from_num(building_count)
		
		#print(slot, " | label: ", building_count)
		
		# Add the item to the slot
		slot.item = building
		
		# Update the item's icon
		slot.item_icon = globals.inventory_buildings[building]["icon_region"]
		
		# Tell the slot this item is a building
		slot.item_type = "building"
		
		# Add the correct quantity of the item into the slot
		slot.quantity =  globals.inventory_buildings[building]["stock"]
		
	# Add the dragged item to the slot
	#slot.item = dragging
	##print("dragging in slot: ", dragging)
	## Show the item's icon in the slot
	#slot.item_icon = dragging_array[dragging]["icon_region"]
	## Set the slot to te correct type
	#slot.item_type = "building" if dragging_array == globals.inventory_buildings else "ingredients"
	#

# Returns the slot from its label
func get_slot_from_num(label):
	for slot in get_node("HotbarGrid").get_children():
		if slot.label == str(label):
			return slot

# Initiate slot values
func initiate_slots():
	var slot_number = 0
	
	# Update the slots
	for slot in get_node("HotbarGrid").get_children():
		slot_number += 1
		
		# Set the correct label
		slot.label = str(slot_number)
		
		# Update the slots opacity to be more opaque if it is selected
		if slot_number == slot_focused:
			slot.modulate = Color(1, 1, 1, 1)
		else:
			slot.modulate = Color(1, 1, 1, opacity)
