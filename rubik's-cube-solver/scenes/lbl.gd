extends Node3D

@onready var cube = $"../../Cube"
var solver_speed = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lbl"):
		var moves = ["f","b","l","r","u","d"]
		var prim = [true,false]
		var move = [moves.pick_random(),prim.pick_random()]
		cube.bot_move(move)
		await get_tree().create_timer(solver_speed).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
