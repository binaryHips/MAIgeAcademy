extends Node

const base_time_between_turns:float = 0.5
var time_between_updates:float = 0.01
var speed_scale = time_between_updates * 100

var intertwine_dog_turns: bool = true

var length_in_rounds:int = 50

var n_sheep:int = 5

var max_candy:int = 8
var teacher_speed_factor:float = 4.0
var student_speed:float = 50.0/speed_scale
var teacher_speed:float =  student_speed * teacher_speed_factor
var dog_speed:float = 100.0
var sheep_speed:float = 40.0
var base_game_length:float = 50.0
var birds_per_turn = 1
var candy_chance = 0.003

var infos_visible := false

func update_speed(t_b_u):
	time_between_updates = t_b_u
	Gamemaster.turn_timer.wait_time = time_between_updates
	speed_scale = time_between_updates * 20
	student_speed = 50.0/speed_scale
	teacher_speed = student_speed * teacher_speed_factor
	
