extends Node3D

var prim_move = false
var is_rotating := false
var human_move = null
var speed = null

@onready var center1 = $center1
@onready var center2 = $center2
@onready var center3 = $center3
@onready var center4 = $center4
@onready var center5 = $center5
@onready var center6 = $center6
@onready var edge1 = $edge1
@onready var edge2 = $edge2
@onready var edge3 = $edge3
@onready var edge4 = $edge4
@onready var edge5 = $edge5
@onready var edge6 = $edge6
@onready var edge7 = $edge7
@onready var edge8 = $edge8
@onready var edge9 = $edge9
@onready var edge10 = $edge10
@onready var edge11 = $edge11
@onready var edge12 = $edge12
@onready var corner1 = $corner1
@onready var corner2 = $corner2
@onready var corner3 = $corner3
@onready var corner4 = $corner4
@onready var corner5 = $corner5
@onready var corner6 = $corner6
@onready var corner7 = $corner7
@onready var corner8 = $corner8

var cubies = []

var solved_state = [
	{ "name": "center1", "grid_pos": Vector3i(1, 0, 0), "rotation": Vector3(0, 0, -90) },
	{ "name": "center2", "grid_pos": Vector3i(-1, 0, 0), "rotation": Vector3(0, 0, 90) },
	{ "name": "center3", "grid_pos": Vector3i(0, 0, 1), "rotation": Vector3(90, 0, 0) },
	{ "name": "center4", "grid_pos": Vector3i(0, 0, -1), "rotation": Vector3(-90, 0, 0) },
	{ "name": "center5", "grid_pos": Vector3i(0, 1, 0), "rotation": Vector3(0, 0, 0) },
	{ "name": "center6", "grid_pos": Vector3i(0, -1, 0), "rotation": Vector3(-180, 0, 0) },

	{ "name": "edge1", "grid_pos": Vector3i(1, 0, 1), "rotation": Vector3(90, 0, 0) },
	{ "name": "edge2", "grid_pos": Vector3i(1, 0, -1), "rotation": Vector3(-90, 0, 0) },
	{ "name": "edge3", "grid_pos": Vector3i(-1, 0, 1), "rotation": Vector3(-90, -180, 0) },
	{ "name": "edge4", "grid_pos": Vector3i(-1, 0, -1), "rotation": Vector3(90, -180, 0) },
	{ "name": "edge5", "grid_pos": Vector3i(0, 1, 1), "rotation": Vector3(0, -90, 0) },
	{ "name": "edge6", "grid_pos": Vector3i(1, 1, 0), "rotation": Vector3(0, 0, 0) },
	{ "name": "edge7", "grid_pos": Vector3i(-1, 1, 0), "rotation": Vector3(0, -180, 0) },
	{ "name": "edge8", "grid_pos": Vector3i(0, 1, -1), "rotation": Vector3(0, 90, 0) },
	{ "name": "edge9", "grid_pos": Vector3i(0, -1, 1), "rotation": Vector3(0, 90, 180) },
	{ "name": "edge10", "grid_pos": Vector3i(1, -1, 0), "rotation": Vector3(180, 0, 0) },
	{ "name": "edge11", "grid_pos": Vector3i(-1, -1, 0), "rotation": Vector3(0, 0, 180) },
	{ "name": "edge12", "grid_pos": Vector3i(0, -1, -1), "rotation": Vector3(0, -90, 180) },

	{ "name": "corner1", "grid_pos": Vector3i(1, 1, 1), "rotation": Vector3(0, 0, 0) },
	{ "name": "corner2", "grid_pos": Vector3i(1, 1, -1), "rotation": Vector3(0, 90, 0) },
	{ "name": "corner3", "grid_pos": Vector3i(-1, 1, -1), "rotation": Vector3(0, -180, 0) },
	{ "name": "corner4", "grid_pos": Vector3i(-1, 1, 1), "rotation": Vector3(0, -90, 0) },
	{ "name": "corner5", "grid_pos": Vector3i(1, -1, 1), "rotation": Vector3(0, 90, 180) },
	{ "name": "corner6", "grid_pos": Vector3i(1, -1, -1), "rotation": Vector3(-180, 0, 0) },
	{ "name": "corner7", "grid_pos": Vector3i(-1, -1, -1), "rotation": Vector3(0, -90, 180) },
	{ "name": "corner8", "grid_pos": Vector3i(-1, -1, 1), "rotation": Vector3(0, 0, 180) }
]

var start_colors = [
	Color.RED, Color.ORANGE, Color.BLUE, Color.GREEN, Color.WHITE, Color.YELLOW
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cubies = [
		center1, center2, center3, center4, center5, center6,
		edge1, edge2, edge3, edge4, edge5, edge6,
		edge7, edge8, edge9, edge10, edge11, edge12,
		corner1, corner2, corner3, corner4,
		corner5, corner6, corner7, corner8
	]
	
	for i in range(cubies.size()):
		cubies[i].grid_pos = solved_state[i]["grid_pos"]
		cubies[i].rot_degrees = solved_state[i]["rotation"]
		cubies[i].apply_state()
	
	center1.apply_color(Color.RED)
	center2.apply_color(Color.ORANGE)
	center3.apply_color(Color.BLUE)
	center4.apply_color(Color.GREEN)
	center5.apply_color(Color.YELLOW)
	center6.apply_color(Color.WHITE)
	
	edge1.apply_color(Color.BLUE, Color.RED)
	edge2.apply_color(Color.GREEN, Color.RED)
	edge3.apply_color(Color.BLUE, Color.ORANGE)
	edge4.apply_color(Color.GREEN, Color.ORANGE)

	edge5.apply_color(Color.YELLOW, Color.BLUE)
	edge6.apply_color(Color.YELLOW, Color.RED)
	edge7.apply_color(Color.YELLOW, Color.ORANGE)
	edge8.apply_color(Color.YELLOW, Color.GREEN)

	edge9.apply_color(Color.WHITE, Color.BLUE)
	edge10.apply_color(Color.WHITE, Color.RED)
	edge11.apply_color(Color.WHITE, Color.ORANGE)
	edge12.apply_color(Color.WHITE, Color.GREEN)
	
	corner1.apply_color(Color.YELLOW, Color.RED, Color.BLUE)
	corner2.apply_color(Color.YELLOW, Color.GREEN, Color.RED)
	corner3.apply_color(Color.YELLOW, Color.ORANGE, Color.GREEN)
	corner4.apply_color(Color.YELLOW, Color.BLUE, Color.ORANGE)

	corner5.apply_color(Color.WHITE, Color.BLUE, Color.RED)
	corner6.apply_color(Color.WHITE, Color.RED, Color.GREEN)
	corner7.apply_color(Color.WHITE, Color.GREEN, Color.ORANGE)
	corner8.apply_color(Color.WHITE, Color.ORANGE, Color.BLUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("prim"):
		prim_move = true
		return
	if event.is_action_released("prim"):
		prim_move = false
		return
	if event.is_action_pressed("front"):
		human_move = true
		rotate_front()
	if event.is_action_pressed("behind"):
		human_move = true
		rotate_back()
	if event.is_action_pressed("left"):
		human_move = true
		rotate_left()
	if event.is_action_pressed("right"):
		human_move = true
		rotate_right()
	if event.is_action_pressed("up"):
		human_move = true
		rotate_up()
	if event.is_action_pressed("down"):
		human_move = true
		rotate_down()
	if event.is_action_pressed("transparency"):
		for cube in cubies:
			cube.toggle_transparency()

func rotate_front():
	if prim_move:
		rotate_layer_z(1, -90)
	else:
		rotate_layer_z(1, 90)
func rotate_back():
	if prim_move:
		rotate_layer_z(-1, 90)
	else:
		rotate_layer_z(-1, -90)
func rotate_right():
	if prim_move:
		rotate_layer_x(1, -90)
	else:
		rotate_layer_x(1, 90)
func rotate_left():
	if prim_move:
		rotate_layer_x(-1, 90)
	else:
		rotate_layer_x(-1, -90)
func rotate_up():
	if prim_move:
		rotate_layer_y(1, -90)
	else:
		rotate_layer_y(1, 90)
func rotate_down():
	if prim_move:
		rotate_layer_y(-1, 90)
	else:
		rotate_layer_y(-1, -90)

func rotate_layer_x(xv: int, angle: float):
	_rotate_layer(Vector3i(xv, 0, 0), Vector3(1,0,0), angle)
func rotate_layer_y(yv: int, angle: float):
	_rotate_layer(Vector3i(0, yv, 0), Vector3(0,1,0), angle)
func rotate_layer_z(zv: int, angle: float):
	_rotate_layer(Vector3i(0, 0, zv), Vector3(0,0,1), angle)

func _rotate_layer(axis_value: Vector3i, axis: Vector3, angle: float):
	if is_rotating:
		return
	is_rotating = true
	if human_move:
		speed = 0.15
	else:
		speed = 0
	var pivot = Node3D.new()
	add_child(pivot)
	var cube_size = 0.6
	pivot.global_position = Vector3(axis_value) * cube_size
	pivot.rotation_degrees = Vector3.ZERO
	var affected = []
	for c in cubies:
		if (
			(axis.x != 0 and c.grid_pos.x == axis_value.x) or
			(axis.y != 0 and c.grid_pos.y == axis_value.y) or
			(axis.z != 0 and c.grid_pos.z == axis_value.z)
		):
			affected.append(c)
	for c in affected:
		var t = c.global_transform
		c.reparent(pivot)
		c.global_transform = t
	var tween = create_tween()
	tween.tween_property(
		pivot,
		"rotation_degrees",
		pivot.rotation_degrees + axis * angle,
		speed
	)
	await tween.finished
	for c in affected:
		var t = c.global_transform
		c.reparent(self)
		c.global_transform = t
		c.grid_pos = Vector3i(
			round(c.global_position.x / cube_size),
			round(c.global_position.y / cube_size),
			round(c.global_position.z / cube_size)
		)
		c.position = Vector3(c.grid_pos) * cube_size
	pivot.queue_free()
	is_rotating = false
	
func bot_move(move):
	var site = move[0]
	prim_move = move[1]
	if site == "f":
		human_move = false
		rotate_front()
	if site == "b":
		human_move = false
		rotate_back()
	if site == "l":
		human_move = false
		rotate_left()
	if site == "r":
		human_move = false
		rotate_right()
	if site == "u":
		human_move = false
		rotate_up()
	if site == "d":
		human_move = false
		rotate_down()

func get_state():
	var state = []
	for c in cubies:
		state.append({
			"name": c.name,
			"pos": c.grid_pos,
			"rot": c.rot_degrees
		})
	return state
