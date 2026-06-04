extends Camera3D

@export var distance := 5.0
@onready var rig := get_parent()

func _process(delta):
	var rot = rig.get_camera_rotation()

	var x = distance * cos(rot.x) * sin(rot.y)
	var y = distance * sin(rot.x)
	var z = distance * cos(rot.x) * cos(rot.y)

	global_position = Vector3(x, y, z)
	look_at(Vector3.ZERO, Vector3.UP)
