extends Node3D

var grid_pos: Vector3i
var pos_multiply = 0.6

@onready var sticker1 = $sticker1 # np. X face
@onready var sticker2 = $sticker2 # np. Y face
@onready var body = $body


func apply_state():
	position = Vector3(grid_pos) * pos_multiply


func apply_color(c1: Color, c2: Color):
	_set_color(sticker1, c1)
	_set_color(sticker2, c2)


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


func _set_alpha(mesh: MeshInstance3D, alpha: float):
	var mat = mesh.get_surface_override_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)

	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color.a = alpha


# ===== FIX: NO GUESSING =====
# zakładamy:
# sticker1 = +/-X
# sticker2 = +/-Z (albo Y – zależnie od Twojego modelu)

func get_face_colors():
	var b = global_transform.basis

	return {
		"U": _color_from_dir(Vector3.UP),
		"D": _color_from_dir(Vector3.DOWN),
		"R": _color_from_dir(Vector3.RIGHT),
		"L": _color_from_dir(Vector3.LEFT),
		"F": _color_from_dir(Vector3.FORWARD),
		"B": _color_from_dir(Vector3.BACK)
	}


func _color_from_dir(dir: Vector3) -> Color:
	var best_dot := -INF
	var best_color := Color.BLACK

	var stickers = [sticker1, sticker2]

	for s in stickers:
		var mat = s.get_surface_override_material(0)
		if mat == null:
			continue

		# ORIENTACJA STICKERA W ŚWIECIE
		var normal = s.global_transform.basis.z.normalized()

		var d = normal.dot(dir)
		if d > best_dot:
			best_dot = d
			best_color = mat.albedo_color

	return best_color


func _get_color(sticker: MeshInstance3D):
	var mat = sticker.get_surface_override_material(0)
	if mat:
		return mat.albedo_color
	return null


func get_orientation():
	return global_transform.basis
