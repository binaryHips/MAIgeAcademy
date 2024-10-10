extends Node

var time_between_turns:float = 2.0

var world_state:Dictionary = {
	"sheep_in" = [],
}



var turn_order:Array[Brain]
var current_turn:int = 0


@onready var turn_timer:Timer = Timer.new()

func _ready() -> void:
	
	add_child(turn_timer)
	turn_timer.wait_time = time_between_turns
	turn_timer.start()
	turn_timer.timeout.connect(next_turn)


## calls the next turn. By default, triggered by a timer of length time_between_turns
func next_turn():
	
	if turn_order == []: return
	
	turn_order[current_turn].run()
	
	current_turn = (current_turn + 1) % turn_order.size()
