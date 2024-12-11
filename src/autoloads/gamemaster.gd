extends Node

var world_state:Dictionary = {
	"candies": []
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
	agents.assign(get_tree().get_nodes_in_group("agents"))
	print("----------------------------------")
	print("At the start of the Game : ")
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
