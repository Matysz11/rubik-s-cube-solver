extends Node

@onready var cube = $"../../Cube"

var random_steps = 60

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("randomize"):
		var moves = ["f","b","l","r","u","d"]
		var prim = [true,false]
		for i in range(random_steps):
			var move = [moves.pick_random(),prim.pick_random()]
			cube.bot_move(move)
			await get_tree().create_timer(0.15).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
