extends Node3D

@onready var cube = $"../../Cube"
var solver_speed = 0.15

enum Phase {
	CROSS,
	FIRST_LAYER,
	SECOND_LAYER,
	OLL,
	PLL
}

var phase = Phase.CROSS
var is_done = null
var running = false

var current_state = []







#var moves = ["f","b","l","r","u","d"]
#var prim = [true,false]
#var move = [moves.pick_random(),prim.pick_random()]
#cube.bot_move(move)





func _input(event):
	if event.is_action_pressed("lbl") and !running:
		running = true
		run_solver()

func run_solver():
	is_done = false
	while !is_done:
		step()
		await get_tree().create_timer(solver_speed).timeout
	running = false
	phase = 0

func step():
	current_state = cube.get_state()
	print(current_state)
	match phase:
		Phase.CROSS:
			print("cross")
			if is_cross_done():
				phase = Phase.FIRST_LAYER

		Phase.FIRST_LAYER:
			print("fl")
			if is_first_layer_done():
				phase = Phase.SECOND_LAYER

		Phase.SECOND_LAYER:
			print("sl")
			if is_second_layer_done():
				phase = Phase.OLL

		Phase.OLL:
			print("oll")
			if is_oll_done():
				phase = Phase.PLL

		Phase.PLL:
			print("pll")
			if is_pll_done():
				is_done = true
				print("skończone")

func is_cross_done():
	return true
func is_first_layer_done():
	return true
func is_second_layer_done():
	return true
func is_oll_done():
	return true
func is_pll_done():
	return true
