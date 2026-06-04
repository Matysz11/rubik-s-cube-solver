extends MeshInstance3D

var grid_pos: Vector3i
var rot_degrees: Vector3
var pos_multiply = 0.6
var colors := {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_state():
	self.position = Vector3(grid_pos) * pos_multiply
	self.rotation_degrees = rot_degrees
