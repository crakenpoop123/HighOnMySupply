extends Node2D

var crushing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Press/PressSprite.frame = 0
	$CrushedCane.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if crushing:
		$Press/PressSprite.play()
		
		# If the press is on the last frame
		print("Press frame: ", $Press/PressSprite.frame)
		if $Press/PressSprite.frame == 10:
			$CrushedCane.visible = true
			$Ingredients/ShreddedCane
			$CrushedCane/CaneTimer.start()
			crushing = false
	else:
		$Press/PressSprite.stop()
		$Press/PressSprite.frame = 0


func _on_press_area_area_entered(area: Area2D) -> void:
	if area.name == "ShreddedCane":
		globals.can_drag = false
		crushing = true


func _on_crush_timer_timeout() -> void:
	globals.change_scene(false)
