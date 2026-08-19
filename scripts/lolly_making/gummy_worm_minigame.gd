extends Node2D

@onready var mouse = $Mouse
@onready var sugar = $Table/Sugar
@onready var saucepan = $Table/Saucepan
@onready var gelatin = $Table/Gelatin
@onready var water = $Table/Water

var animation_playing = false
var empty_saucepan = load("res://assets/misc/saucepan.png")
var water_saucepan = load("res://assets/misc/water-saucepan.png")
var all_ingrediants_in_pot = false
var ingredients_in_pot = 0
var starting_to_close: bool = false

func _ready() -> void:
	$Table/Saucepan/SaucepanSprite.texture = empty_saucepan # SET SAUCEPAN TO BE EMPTY CAUSE OF CODE IN COOKING MINIGAME

func _process(_delta: float) -> void: 
	if ingredients_in_pot == 3: # WHEN THE SAUCEPAN HAS EVERYTHING
		if starting_to_close == false: # WHAT?
			all_ingrediants_in_pot = true # ALL INGREDIANTS IN THE POT IS TRUE
	elif ingredients_in_pot == 2:
		gelatin.visible = true # MAKE THE GELATIN VISIBLE WHEN THE OTHER TWO HAVE BEEN PUT IN

	check_for_move()
	check_for_drop()

func check_for_move():
	if mouse.holding == false: # MOVES THE ITEM WHEN YOU ARE HOLDING IT
		if mouse.holding_click == false: # IF YOU ARENT HOLDING CLICK
			mouse.holding = false # DROP IT
			if sugar.inside_pot == true:
				$Table/Sugar/IngrediantArea.queue_free() # MAKES IT SO YOU CAN'T DRAG IT
				sugar.reparent(saucepan) # MAKES IT SO THAT IT MOVES WITH THE SAUCEPAN
				sugar.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if gelatin.inside_pot == true:
				$Table/Gelatin/IngrediantArea.queue_free()# MAKES IT SO YOU CAN'T DRAG IT
				gelatin.reparent(saucepan) # MAKES IT SO THAT IT MOVES WITH THE SAUCEPAN
				gelatin.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if water.inside_pot == true:
				$Table/Saucepan/SaucepanSprite.texture = water_saucepan
				$Table/Water/IngrediantArea.queue_free()# MAKES IT SO YOU CAN'T DRAG IT
				$Table/Water/IngrediantSprite.queue_free() # BOTTLE NOT NEEDED NO NO NO NOT ANYMORE
				water.reparent(saucepan) # MAKES IT SO THAT IT MOVES WITH THE SAUCEPAN
				water.dropped_into_pot = true
				ingredients_in_pot += 1 # Why doesnt this add 1 infinitely??
			if all_ingrediants_in_pot == true:
				if saucepan.on_oven == true:
					move_to_stove() # MOVE CAMERA TO STOVE
					$AnimationPlayer.play("stove") # TURN STOVE ON
					if starting_to_close == false:# START THE TIMER TO CHANGE SCENE
						$Timer.start()
						starting_to_close = true
						
func check_for_drop(): # Somehow I don't understand my own code so just don't touch this becuase if it breaks I can't fix it
	if mouse.holding == false: # IF YOU ARENT HOLDING ANYTHING
		if mouse.mouse_in_area == true:# WHEN YOU ARE IN AN AREA
			if mouse.holding_click == true: # AND YOU ARE HOLDING CLICK
				mouse.holding = true # START DRAGGING # Should't this be stop dragging???

func move_to_stove():# MOVE CAMERA TO STOVE
	var tween = get_tree().create_tween()
	tween.tween_property($Mouse/Camera, "position", Vector2(-300, 0), 1.0)


func _on_timer_timeout() -> void: # CHANGE SCENE ON TIMER TIMOUT
	globals.saucepan_on_table = false
	globals.change_scene(false)
	
