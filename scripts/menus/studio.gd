extends CanvasLayer

func _on_timer_timeout() -> void: # CHANGE SCENE
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
