extends CanvasLayer
var bob_direction = 1

const TUTORIAL = preload("res://scenes/gui/menus/tutorial.tscn")

func _on_basement_button_up() -> void: # Change scene
		get_tree().change_scene_to_file("res://scenes/areas_in_world/basement.tscn")

func _ready() -> void:
	$Main/Buttons/Basement.global_position = Vector2(494,378)
	
func _process(delta: float) -> void:
	var basement_button = $Main/Buttons/Basement
	var tutorial_button = $Main/Buttons/Tutorial
	
	basement_button.global_position.y += 0.2*bob_direction
	tutorial_button.global_position.y += -0.2*bob_direction

	if basement_button.global_position.y >= 400:
		bob_direction = -1
	elif basement_button.global_position.y <= 378:
		bob_direction = 1


func _on_tutorial_button_up() -> void:
	var tutorial = TUTORIAL.instantiate()
	add_child(tutorial)
