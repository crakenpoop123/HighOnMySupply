extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $ShittyTempChar.in_pot_menu == true:
		$Text.text = "Press E to close menu"
	else:
		$Text.text = "Press E to start mixing ingrediants"
