extends Node3D

var grid_pos: Vector3i
var rot_degrees: Vector3
var pos_multiply = 0.6
var colors := {}
@onready var sticker1 = $sticker1
@onready var body = $body

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StandardMaterial3D.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_state():
	self.position = Vector3(grid_pos) * pos_multiply
	self.rotation_degrees = rot_degrees

func apply_color(color: Color):
	var mat = sticker1.get_surface_override_material(0)

	if mat == null:
		mat = StandardMaterial3D.new()
		sticker1.set_surface_override_material(0, mat)

	mat.albedo_color = color

func toggle_transparency():
	body.visible = !body.visible
	var alpha = 0.4 if !body.visible else 1.0
	_set_alpha(sticker1, alpha)

func _set_alpha(mesh: MeshInstance3D, alpha: float):
	var mat := mesh.get_surface_override_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color.a = alpha
