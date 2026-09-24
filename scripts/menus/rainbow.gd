extends Control

func _ready() -> void:
	$Rainbow.visible = false

func play_animation():
	$Rainbow.visible = true
	$RainbowAnimation.play("RainbowSpin") # Plays the rainbow spinning animation when its called from elsewhere
