extends Node2D

var crushing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get rid of one shredded cane
	globals.inventory_ingredients["shredded_cane"]["stock"] -= 1
	
	# Set the PressSPrite frame to the first one
	$Press/PressSprite.frame = 0
	# Hide the crushred cane
	$CrushedCane.visible = false
	
	# Init the region of the Cane Juice to be empty
	$CaneJuice.region_rect = Rect2(0, 0, 32, 32)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Run while the press is currently crushing
	if crushing:
		# Play the Press animation
		$Press/PressSprite.play()
		
		# If the press is on the frame which has it fully down
		if $Press/PressSprite.frame == 5:
			# Show the crushed cane
			$CrushedCane.visible = true
			
			# Change the CaneJuice to be filled
			$CaneJuice.region_rect = Rect2(192, 0, 32, 32)
			
			# Hide the shredded cane
			$Ingredients/ShreddedCane.visible = false
			
			# Start a timer that will change the scene when it terminates
			$CrushedCane/CaneTimer.start()
		
		# When the Press goes all the way down and all the way back up
		if $Press/PressSprite.frame == 10:
			# Stop cruhing
			crushing = false
	else:
		# Stop the press animation
		$Press/PressSprite.stop()
		# Set the press sprite to the first frame
		$Press/PressSprite.frame = 0


# When the shredded cane touches the press
func _on_press_area_area_entered(area: Area2D) -> void:
	if area.name == "ShreddedCane":
		# Stop dragging
		globals.can_drag = false
		# Start crushing
		crushing = true


# Delay after cane is crushed
func _on_cane_timer_timeout() -> void:
	# Gain one crushed cane
	globals.inventory_ingredients["crushed_cane"]["stock"] += 1
	# Gain one cane juice
	globals.inventory_ingredients["cane_juice"]["stock"] += 1
	
	# Change scene
	globals.change_scene(false)
