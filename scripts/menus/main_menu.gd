extends CanvasLayer

func _on_basement_button_up() -> void: # Change scene
		get_tree().change_scene_to_file("res://scenes/areas_in_world/basement.tscn")
