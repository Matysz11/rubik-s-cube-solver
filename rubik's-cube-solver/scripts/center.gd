extends Node3D

var grid_pos: Vector3i
var pos_multiply = 0.6
var color := Color.WHITE

@onready var sticker1 = $sticker1
@onready var body = $body


func apply_state():
	position = Vector3(grid_pos) * pos_multiply


func apply_color(c: Color):
	_set_color(sticker1, c)
	color = c


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


func _set_alpha(mesh: MeshInstance3D, alpha: float):
	var mat = mesh.get_surface_override_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)

	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color.a = alpha


# center ma tylko jedną prawdę → nie zgadujemy
func get_face_colors():
	var b = global_transform.basis

	return {
		"U": _get_color(sticker1) if abs(b.y.dot(Vector3.UP)) > 0.9 else null,
		"D": _get_color(sticker1) if abs(b.y.dot(Vector3.DOWN)) > 0.9 else null,
		"R": _get_color(sticker1) if abs(b.x.dot(Vector3.RIGHT)) > 0.9 else null,
		"L": _get_color(sticker1) if abs(b.x.dot(Vector3.LEFT)) > 0.9 else null,
		"F": _get_color(sticker1) if abs(b.z.dot(Vector3.FORWARD)) > 0.9 else null,
		"B": _get_color(sticker1) if abs(b.z.dot(Vector3.BACK)) > 0.9 else null
	}


func _get_color(sticker: MeshInstance3D):
	var mat = sticker.get_surface_override_material(0)
	if mat:
		return mat.albedo_color
	return null


func get_orientation():
	return global_transform.basis
