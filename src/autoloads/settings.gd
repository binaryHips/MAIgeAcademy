extends Node

const base_time_between_turns:float = 0.5
var time_between_updates:float = 0.01
var speed_scale = time_between_updates * 100

var intertwine_dog_turns: bool = true

var length_in_rounds:int = 50

var n_sheep:int = 5

var teacher_speed:float = 200.0*speed_scale
var student_speed:float = 80.0*speed_scale
var dog_speed:float = 100.0
var sheep_speed:float = 40.0

var birds_per_turn = 1
var candy_chance = 0.01

func update_speed(t_b_u):
	time_between_updates = t_b_u
	speed_scale = time_between_updates * 100
	teacher_speed = 200.0/speed_scale
	student_speed = 80.0/speed_scale
	"""
	Gamemaster.game_timer.wait_time = (
		(Gamemaster.game_timer.wait_time - Gamemaster.game_timer.time_left) +
		Gamemaster.game_timer.time_left / speed_scale
	)
	"""
