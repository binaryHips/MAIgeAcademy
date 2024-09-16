extends Node

var time_between_turns:float = 2.0

var world_state:Array[String]



var turn_order:Array[Brain]
var current_turn:int = 0



var turn_timer:Timer = Timer.new()
func _ready() -> void:
	
	turn_timer.wait_time = time_between_turns
	turn_timer.start()


## calls the next turn. By default, triggered by a timer of length time_between_turns
func next_turn():
	
	if turn_order == []: return
	
	turn_order[current_turn].run()
	
	current_turn = (current_turn + 1) % turn_order.size()
