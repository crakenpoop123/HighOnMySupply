extends Control

var curr_npc = null

func display_text(text: String, npc):
	# Update text
	$RichTextLabel.text = text
	
	# Set curr npc
	curr_npc = npc
	
	# Show the textbox
	curr_npc.see_text = true
	globals.see_text = true


func _on_button_button_up() -> void:
	# Hide the textbox
	curr_npc.see_text = false
	globals.see_text = false
