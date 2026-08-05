extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/lolly_making/lolly_making_system.tscn")


func _on_sugar_making_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/sugar_making/sugar_making_system.tscn")


func _on_basement_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/areas_in_world/basement.tscn")
