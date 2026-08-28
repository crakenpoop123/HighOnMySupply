extends CharacterBody2D

@onready var nav_agent = $NavigationAgent2D
const SPEED = 300


var corner_one = Vector2i(1050, -1750)
var corner_two = Vector2i(2390, -170)
var width = abs(corner_one.x - corner_two.x)
var height = abs(corner_one.y - corner_two.y)

func _ready() -> void:
	nav_agent.navigation_finished.connect(on_nav_finished)
	nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)
	make_path(Vector2(randf_range(1050,width), randf_range(2390,height)))

func _physics_process(delta: float) -> void:
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	var new_velocity = direction * SPEED
	
	nav_agent.velocity = new_velocity

func on_nav_finished():
	make_path(Vector2(randf_range(1050,width), randf_range(2390,height)))
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 100)
	move_and_slide()
	
func make_path(pos: Vector2):
	nav_agent.target_position = pos
