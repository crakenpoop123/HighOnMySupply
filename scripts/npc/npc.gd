extends CharacterBody2D

var near_pot: bool = false

const SPEED = 300.0

var target_speed = Vector2.ZERO
var movement_smoothing = 5

var npc_dir = 0
var dir_state = "down"

var time = randi_range(1, 5)

func _ready() -> void:
	$".".global_position = $"..".start * 32

func _physics_process(_delta: float) -> void:
	
	#move()
	get_npc_dir()
	orient_animation()
	# Normalise the speed. This ensures diagonal movement is the same speed as rectilinear motion
	target_speed = target_speed.normalized() * SPEED
	
	velocity += (target_speed - velocity) / movement_smoothing
	
	move_and_slide()

func decide_dir():
	time = randf_range(1, 2)
	move()

var i = 0
@onready var array_size = $"../Line2D".points.size()
func move():
	#print(i)
	array_size = $"../Line2D".points.size()
	if array_size != i:
		if $"../Line2D".points.is_empty() == true: # This barely works
			$"..".rando_path()
		else:
			$".".global_position = $"../Line2D".points[i] + Vector2(-1280, -2720)
			i += 1
			$MoveTimer.start(0.2)
	elif array_size == i:
		i = 0
		$"..".rando_path()
		
		# DIrection vector = target_pos - curr_pos
		#vector.normalise
		# Velocity = vector * speed
		# Wait until toucjhing
		
		
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
