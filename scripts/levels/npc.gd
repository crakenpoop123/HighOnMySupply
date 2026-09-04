extends CharacterBody2D
@onready var nav_agent = $NavigationAgent2D
const SPEED = 300

var target_speed = Vector2.ZERO
var movement_smoothing = 5

var left = 1040
var right = 2400
var top = -1760
var bottom = -160
var dir_state = "down"
var npc_dir = 0

var npc_responses = ["Hello", "Hello2", "Hello3"]
#var ai_response: String = YOUR AI STUFF HERE CLARK

func _ready() -> void:
	nav_agent.navigation_finished.connect(on_nav_finished)
	nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)
	make_path(Vector2(randi_range(left,right), randi_range(bottom,top)))
	
func _physics_process(_delta: float) -> void:
	get_player_dir()
	orient_animation()
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	var new_velocity = direction * SPEED
	nav_agent.velocity = new_velocity
	target_speed = nav_agent.velocity
func on_nav_finished():
	make_path(Vector2(randi_range(left,right), randi_range(bottom,top)))
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 100)
	move_and_slide()
	
func make_path(pos: Vector2):
	nav_agent.target_position = pos


func player_interact():
	$"../../Player".talking(npc_responses[randi_range(1-1, 3-1)])
	#$"../../Player".talking(ai_response)

func get_player_dir():
	if target_speed.length() != 0:
		npc_dir = target_speed.angle()
		print("player direction", npc_dir)

func orient_animation():
	if npc_dir >= -PI/4 - 0.001 and npc_dir <= PI/4 + 0.001:
		dir_state = "right"
	elif npc_dir >= 3*PI/4 or npc_dir <= -3*PI/4:
		dir_state = "down"
	elif npc_dir > PI/4 and npc_dir < 3*PI/4:
		dir_state = "left"
	elif npc_dir > -3 * PI/4 and npc_dir < -PI/4:
		dir_state = "up"
	#print(dir_state)
	
	call_correct_animation()

func call_correct_animation():
	var animation = "move_" #if target_speed.length() != 0 else "idle_"
	animation = animation + dir_state
	
	#print(animation)
	$AnimatedSprite2D.play(animation)
