extends Node




var world_state:Dictionary = {
	"sheep_in" = [],
	"out_of_bounds" = [],
}

var main_scene:Node2D

var turn_order:Array[Brain]


@onready var turn_timer:Timer = Timer.new()

signal game_started
signal game_ended(result:int)

##WARNING Async!
signal new_round(num:int)
signal new_turn(player_idx:int)

func _ready() -> void:
	
	add_child(turn_timer)


func start_game():
	turn_timer.start()
	turn_timer.wait_time = Settings.time_between_turns
	turn_timer.timeout.connect(next_turn)

var round_count:int
var current_turn:int = 0
## calls the next turn. By default, triggered by a timer of length time_between_turns
func next_turn():
	if turn_order == []: return
	if current_turn == 0:
		round_count += 1
		new_round.emit(round_count)
	
	new_turn.emit(current_turn)
	turn_order[current_turn].run()
	
	current_turn = (current_turn + 1) % turn_order.size()
	
	if round_count == Settings.length_in_rounds:
		end()
	
func end():
	print("FINI")
	turn_timer.stop()
	get_tree().change_scene_to_file("res://src/scenes/end/End.tscn")
	#get_tree().paused = true
	
func win():
	game_ended.emit(0)
	
