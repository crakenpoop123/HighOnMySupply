extends TextureRect

var Code: String

var recentKey: Key

# Init the keybinding
func _ready() -> void:
	$Event.text = Code
	pass

# Setup the signal passed to the keybinds parent
signal pressed(button: String, Code: String)

# Send messages to the keybinds parent:

func _on_add_button_up() -> void:
	pressed.emit("add", Code)


func _on_reset_button_up() -> void:
	pressed.emit("reset", Code)


func _on_list_button_up() -> void:
	pressed.emit("list", Code)
