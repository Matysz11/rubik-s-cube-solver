extends MeshInstance3D

var grid_pos: Vector3i
var rot_degrees: Vector3
var pos_multiply = 0.6
var colors := {}
@onready var sticker1 = $sticker1
@onready var sticker2 = $sticker2
@onready var sticker3 = $sticker3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_state():
	self.position = Vector3(grid_pos) * pos_multiply
	self.rotation_degrees = rot_degrees


func apply_color(c1: Color, c2: Color, c3: Color):
	var mat1 = sticker1.get_surface_override_material(0)
	if mat1 == null:
		mat1 = StandardMaterial3D.new()
		sticker1.set_surface_override_material(0, mat1)
	mat1.albedo_color = c1

	var mat2 = sticker2.get_surface_override_material(0)
	if mat2 == null:
		mat2 = StandardMaterial3D.new()
		sticker2.set_surface_override_material(0, mat2)
	mat2.albedo_color = c2

	var mat3 = sticker3.get_surface_override_material(0)
	if mat3 == null:
		mat3 = StandardMaterial3D.new()
		sticker3.set_surface_override_material(0, mat3)
	mat3.albedo_color = c3
