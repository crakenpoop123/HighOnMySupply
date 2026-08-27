extends Node2D
# done with plenty of help from https://kidscancode.org/godot_recipes/4.x/2d/grid_pathfinding/index.html

var cell_size = Vector2i(80, 80)

var astar_grid = AStarGrid2D.new()
var grid_size
var grid_x_y_min = 0
var grid_x_max = 71
var grid_y_max = 45
var start = Vector2i(randi_range(grid_x_y_min, grid_x_max), randi_range(grid_x_y_min, grid_y_max))
var end = Vector2i(randi_range(grid_x_y_min, grid_x_max), randi_range(grid_x_y_min, grid_y_max))


func _ready():
	initialize_grid()
	update_path()

var corner_one = Vector2i(-1280, -2720)
var corner_two = Vector2i(4480, 960)
var width = abs(corner_one.x - corner_two.x)
var height = abs(corner_one.y - corner_two.y)

func initialize_grid():
	grid_size = (Vector2i(width, height) + Vector2i.ONE) / cell_size
	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
	astar_grid.offset = Vector2i(cell_size/2)
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
func _draw():
	draw_grid()
	draw_rect(Rect2(start * cell_size, cell_size), Color.GREEN_YELLOW)
	draw_rect(Rect2(end * cell_size, cell_size), Color.ORANGE_RED)
	for x in grid_size.x:
		for y in grid_size.y:
			if astar_grid.is_point_solid(Vector2i(x, y)):
				draw_rect(Rect2(x * cell_size.x, y * cell_size.y, cell_size.x, cell_size.y), Color.DARK_GRAY)
	
	print($Line2D.points)


func update_path():
	$Line2D.points = PackedVector2Array(astar_grid.get_point_path(start, end))

func draw_grid():
	for x in grid_size.x + 1:
		draw_line(Vector2(x * cell_size.x, 0),
		Vector2(x * cell_size.x, grid_size.y * cell_size.y),
		Color.DARK_GRAY, 2.0)
	for y in grid_size.y + 1:
		draw_line(Vector2(0, y * cell_size.y),
		Vector2(grid_size.x * cell_size.x, y * cell_size.y),
		Color.DARK_GRAY, 2.0)

func _input(event):
	if event is InputEventMouseButton:
		# Add/remove wall
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var pos = Vector2i(get_global_mouse_position()) / cell_size
			if astar_grid.is_in_boundsv(pos):
				astar_grid.set_point_solid(pos, not astar_grid.is_point_solid(pos))
			update_path()
			queue_redraw()
			
func rando_path():
	start = end
	end = Vector2i(randi_range(grid_x_y_min, grid_x_max), randi_range(grid_x_y_min, grid_y_max))
	if astar_grid.is_point_solid(end):
		rando_end()
	initialize_grid()
	update_path()
	_draw()
	queue_redraw()
	$NPC.move()

func rando_end():
	end = Vector2i(randi_range(grid_x_y_min, grid_x_max), randi_range(grid_x_y_min, grid_y_max))
	print("end had to be randomised")
	if astar_grid.is_point_solid(end):
		rando_end()
		
