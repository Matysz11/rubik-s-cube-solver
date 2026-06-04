extends Node3D

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cubies = [
		center1, center2, center3, center4, center5, center6,
		edge1, edge2, edge3, edge4, edge5, edge6,
		edge7, edge8, edge9, edge10, edge11, edge12,
		corner1, corner2, corner3, corner4,
		corner5, corner6, corner7, corner8
	]
	
	for i in cubies.size():
		cubies[i].grid_pos = solved_state[i]["grid_pos"]
		cubies[i].rot_degrees = solved_state[i]["rotation"]
		cubies[i].apply_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
