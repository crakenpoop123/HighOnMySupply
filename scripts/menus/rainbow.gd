extends Control

func _ready() -> void:
	$Rainbow.visible = true # Make it visible
	$RainbowAnimation.play("RainbowSpin") # Plays the rainbow spinning animation when its called from elsewhere


func _on_rainbow_animation_animation_finished() -> void:
	self.queue_free() # Destroy it when the animation is done
