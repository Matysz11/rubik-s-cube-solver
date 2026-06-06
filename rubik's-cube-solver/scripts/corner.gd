extends Node3D

var grid_pos: Vector3i
var pos_multiply = 0.6

@onready var sticker1 = $sticker1
@onready var sticker2 = $sticker2
@onready var sticker3 = $sticker3
@onready var body = $body


func apply_state():
	position = Vector3(grid_pos) * pos_multiply


func apply_color(c1: Color, c2: Color, c3: Color):
	_set_color(sticker1, c1)
	_set_color(sticker2, c2)
	_set_color(sticker3, c3)


func _set_color(mesh: MeshInstance3D, c: Color):
	var mat = mesh.get_surface_override_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)

	mat.albedo_color = c


func toggle_transparency():
	body.visible = !body.visible
	var alpha = 0.4 if !body.visible else 1.0

	_set_alpha(sticker1, alpha)
	_set_alpha(sticker2, alpha)
	_set_alpha(sticker3, alpha)


func _set_alpha(mesh: MeshInstance3D, alpha: float):
	var mat = mesh.get_surface_override_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)

	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color.a = alpha


func get_face_colors():
	var b = global_transform.basis

	return {
		"U": _pick(sticker1, b.y, Vector3.UP),
		"D": _pick(sticker1, -b.y, Vector3.DOWN),

		"R": _pick(sticker2, b.x, Vector3.RIGHT),
		"L": _pick(sticker2, -b.x, Vector3.LEFT),

		"F": _pick(sticker3, -b.z, Vector3.FORWARD),
		"B": _pick(sticker3, b.z, Vector3.BACK)
	}


func _pick(sticker: MeshInstance3D, axis: Vector3, dir: Vector3):
	# stabilne przypisanie bez zgadywania
	if axis.dot(dir) > 0.9:
		return _get_color(sticker)
	return null


func _get_color(sticker: MeshInstance3D):
	var mat = sticker.get_surface_override_material(0)
	if mat:
		return mat.albedo_color
	return null


func get_orientation():
	return global_transform.basis
