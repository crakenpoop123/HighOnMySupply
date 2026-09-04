extends Control

func display_text(text: String):
	$RichTextLabel.text = text
	globals.see_text = true
