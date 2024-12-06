extends Node

var world_state:Dictionary = {
	"sheep_in" = [],
	"out_of_bounds" = [],
}

var main_scene:Node2D

var agents:Array[Brain] = []

@onready var turn_timer:Timer = Timer.new()

signal game_started
signal game_ended(result:int)

##WARNING Async!
signal new_round(num:int)
signal new_turn(player_idx:int)

func _ready() -> void:
	add_child(turn_timer)
	start_game()

func start_game():
	agents.clear() 
	
	for obj in world_state["out_of_bounds"]:
		if is_instance_valid(obj):
			obj.queue_free()
			
	world_state["out_of_bounds"].clear()
	print("----------------------------------")
	print("At the start of the Game : " + str(world_state["out_of_bounds"]))
	turn_timer.start()
	turn_timer.wait_time = 0.01#Settings.time_between_turns
	turn_timer.timeout.connect(next_turn)
	emit_signal("game_started")

var round_count:int
## calls the next turn. By default, triggered by a timer of length time_between_turns
func next_turn():
	new_turn.emit()
	for a in agents:
		if is_instance_valid(a): a.run()
	

func end():
	#print("FINI")
	#print("------------------------------------------------------\n")
	turn_timer.stop()
	get_tree().change_scene_to_file("res://src/scenes/end/End.tscn")
	#get_tree().paused = true
	emit_signal("game_ended", 0)
