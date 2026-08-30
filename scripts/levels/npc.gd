extends CharacterBody2D

@onready var nav_agent = $NavigationAgent2D
const SPEED = 300
#
#var min = -1280
#var corner_one = Vector2i(-1280, 960)
#var corner_two = Vector2i(2400, -2720)
#var width = abs(corner_one.x - corner_two.x)
#var height = abs(corner_one.y - corner_two.y)

var bottom_left = Vector2i(-1280, 960) #whoops these shouldnt be vectors
var bottom_right = Vector2i(4480, 960)
var top_left = Vector2i(-1280, -2720)
var top_right = Vector2i(4480, -2720)


func _ready() -> void:
	nav_agent.navigation_finished.connect(on_nav_finished)
	nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)
	make_path(Vector2(randi_range(bottom_left,bottom_right), randi_range(top_left,top_right))) #-1280, 960 # 4480, -2720
	
func _physics_process(delta: float) -> void:
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	var new_velocity = direction * SPEED
	
	nav_agent.velocity = new_velocity

func on_nav_finished():
	make_path(Vector2(randi_range(bottom_left,bottom_right), randi_range(top_left,top_right)))
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 100)
	move_and_slide()
	
func make_path(pos: Vector2):
	nav_agent.target_position = pos
