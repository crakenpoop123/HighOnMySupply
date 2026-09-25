extends Control
const TUTORIAL = preload("res://scenes/gui/menus/tutorial.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.game_paused = false
	$".".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$".".visible = globals.game_paused
	

func _on_resume_button_pressed() -> void:
	globals.game_paused = false


func _on_tutorial_button_pressed() -> void:
	var tutorial = TUTORIAL.instantiate()
	add_child(tutorial)


func _on_keybind_button_pressed() -> void:
	globals.change_scene(true, "res://scenes/gui/menus/keybinds.tscn")
