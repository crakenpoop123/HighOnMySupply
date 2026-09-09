extends Node2D

var drying = false
var dry_time = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get rid of one shredded cane
	globals.inventory_ingredients["wet_sugar"]["stock"] -= 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Run while the press is currently crushing
	if drying:
		# Hide the wet sugar
		$Ingredients/WetSugar.visible = false
		
		# Show sugar in the dryer
		$Dryer/DryerSprite.region_rect = Rect2(64, 0, 32, 32)
		
		# If the press is on the frame which has it fully down
		if $Dryer/DryTimer.time_left == 0:
			$Dryer/DryTimer.start(dry_time)


# When the wet sugar touches the dryer
func _on_dryer_area_area_entered(area: Area2D) -> void:
	if area.name == "WetSugar":
		# Stop dragging
		globals.can_drag = false
		# Start drying
		drying = true


# Wait for the sugar to dry
func _on_dry_timer_timeout() -> void:
	# Gain one sugar
	globals.inventory_ingredients["sugar"]["stock"] += 1

	# Change scene
	globals.change_scene(false)
