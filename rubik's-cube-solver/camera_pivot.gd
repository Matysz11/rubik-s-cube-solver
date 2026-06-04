extends Node3D

@export var sensitivity := 0.01

var yaw := 0.0
var pitch := 0.0

func _ready():
	pitch = deg_to_rad(25)
	yaw = deg_to_rad(45)

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		yaw -= event.relative.x * sensitivity
		pitch += event.relative.y * sensitivity

		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(80))

func get_camera_rotation():
	return Vector3(pitch, yaw, 0)
