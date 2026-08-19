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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
