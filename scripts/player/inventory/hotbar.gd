extends Control

@onready var item = preload("res://scenes/player/inventory/hotbar_item.tscn")
var num_slots = 10

var slot_focused = 0

var opacity = 0.75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for slot in range(num_slots):
		var curr_item = item.instantiate()
		
		$HotbarGrid.add_child(curr_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var slot_number = 0
	for slot in get_node("HotbarGrid").get_children():
		slot.label = str(slot_number)
		if slot_number == slot_focused:
			slot.modulate = Color(1, 1, 1, 1)
		else:
			slot.modulate = Color(1, 1, 1, opacity)
		slot_number += 1
