extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

var target_speed = Vector2.ZERO
var movement_smoothing = 5

var npc_dir = 0
var dir_state = "down"

var time = randi_range(1, 5)
var target_pos
var curr_pos
func _ready() -> void:
	$".".global_position = $"../../Node2D".start
	print($"../../Node2D".start)
func _physics_process(_delta: float) -> void:
	
	#move()
	get_npc_dir()
	orient_animation()
	# Normalise the speed. This ensures diagonal movement is the same speed as rectilinear motion
	target_speed = target_speed.normalized() * SPEED
	
	velocity += (target_speed - velocity) / movement_smoothing
	
	move_and_slide()

func decide_dir():
	move()

var i = 0
@onready var array_size = $"../../Node2D/Line2D".points.size()
func move():
	array_size = $"../../Node2D/Line2D".points.size()
	if array_size != i:
		if $"../../Node2D/Line2D".points.is_empty() == true: # This barely works
			$"../../Node2D".rando_path()
		else:
			target_pos = $"../../Node2D/Line2D".points[i] + Vector2(-1280, -2720)
			curr_pos = $".".global_position
			i += 1
			var vector = target_pos - curr_pos
			vector = vector.normalized()
			velocity = vector * SPEED
			$MoveTimer.start(0)
			
	elif array_size == i:
		if check_if_it_is_at_the_right_spot(Vector2i($"../../Node2D".end), Vector2i($".".global_position)):
			i = 0
			$"../../Node2D".rando_path()
		else:
			i -= 1
		

# Check if it is at the right spot (spot)
func check_if_it_is_at_the_right_spot(spot, pos):
	# Small margin of error it can be within
	var small_margin_of_error_it_can_be_within = Vector2i(0.001, 0.001)
	if pos - small_margin_of_error_it_can_be_within < spot and pos + small_margin_of_error_it_can_be_within > spot:
		return true # returns true
	
	return false # Returns something


func get_npc_dir():
	if target_speed.length() != 0:
		npc_dir = target_speed.angle()
		#print("npc direction", npc_dir)

func orient_animation():
	if npc_dir >= -PI/4 - 0.001 and npc_dir <= PI/4 + 0.001:
		dir_state = "right"
	elif npc_dir >= 3*PI/4 or npc_dir <= -3*PI/4:
		dir_state = "left"
	elif npc_dir > PI/4 and npc_dir < 3*PI/4:
		dir_state = "down"
	elif npc_dir > -3 * PI/4 and npc_dir < -PI/4:
		dir_state = "up"
	
	call_correct_animation()

func call_correct_animation():
	var animation = "move_" if target_speed.length() != 0 else "idle_"
	animation = animation + dir_state
	
	#$npcSprite.play(animation)


func _on_move_timer_timeout() -> void:
	decide_dir()
