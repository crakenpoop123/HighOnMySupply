extends Control

@onready var item = preload("res://scenes/player/inventory/hotbar_item.tscn")
var num_slots = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for slot in range(num_slots):
		var curr_item = item.instantiate()
		
		$HotbarGrid.add_child(curr_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
