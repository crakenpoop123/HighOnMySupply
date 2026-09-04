extends Control

func display_text(text: String):
	$RichTextLabel.text = text
	globals.see_text = true


func _on_button_button_up() -> void:
	globals.see_text = false
