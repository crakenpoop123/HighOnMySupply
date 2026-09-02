extends Node2D

@onready var mouse = $Mouse
@onready var sugarcane = $Table/Sugarcane

func _process(delta: float) -> void:
	
	check_for_move()
	check_for_drop()

func check_for_move():
	if mouse.holding == false: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT
			if sugarcane.inside_shredder == true:
				$AnimationPlayer.play("Sugarcane_Shredded")
				$Table/Sugarcane/SugarcaneArea.queue_free() # MAKES IT SO YOU CAN'T DRAG IT
				sugarcane.dropped_into_shredder = true
				$Timer.start()
			
						
func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING # Should't this be stop dragging???


func _on_timer_timeout() -> void:
	globals.change_scene(false)
