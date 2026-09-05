extends Node2D

var boiling = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Boiler/LiquidInBoiler.visible = false
	$Boiler/LiquidInBoiler.region_rect = Rect2(206, 10, 5.177, 18.574) # This is zoomed in on the green liquid in the boiler 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if boiling:
		# Move the liquid into the boiler
		$Boiler/LiquidInBoiler.visible = true
		$Ingredients/CaneJuice.visible = false
		
		# Play the boiler animation
		$Boiler/BoilerSprite.play()
		
		# When the animation has played through
		if $Boiler/BoilerSprite.frame == 6:
			globals.change_scene(false)
		
	else:
		# Stop the boiler animation
		$Boiler/BoilerSprite.stop()
		# Set the animation to the first frame
		$Boiler/BoilerSprite.frame = 0


func _on_boiler_area_area_entered(area: Area2D) -> void:
	if area.name == "CaneJuice":
		globals.can_drag = false
		boiling = true





#$Boiler/LiquidInBoiler.region_rect = Rect2(142, 10, 5.177, 18.574) # This is zoomed in on a light coloured liquid




# YOU FOUND THE EASTER EGG.
# DID YOU KNOW THAT OUR GAKME WAS 95.1413% WRITTEN BY CLAUDEY WAUDEY
