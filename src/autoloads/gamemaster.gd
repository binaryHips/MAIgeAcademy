extends Node

var world_state:Dictionary = {
	"candies": []
}

var main_scene:Node2D

var agents:Array[Brain] = []

const PIAF = preload("res://src/scenes/oiseau/oiseau.tscn")

var current_level_data := {}  #set from the menu
var students_by_strategy := {} #set from the menu

var progress := 0.0:
	set(v):
		if v>=1.0:
			end()
		progress = v

@onready var turn_timer:Timer = Timer.new()


signal game_started
signal game_ended(result:int)

##WARNING Async!
signal new_round(num:int)
signal new_turn(player_idx:int)

func _ready() -> void:
	add_child(turn_timer)

func start_game():
	agents.clear()
	#agents.assign(get_tree().get_nodes_in_group("agents"))
	print("----------------------------------")
	print("At the start of the Game : ")
	turn_timer.start()
	Settings.update_speed(0.05)
	turn_timer.wait_time = Settings.time_between_updates
	turn_timer.timeout.connect(next_turn)
	progress = 0.0
	get_tree().change_scene_to_packed(current_level_data["scene"])
	emit_signal("game_started")

var round_count:int
## calls the next turn. By default, triggered by a timer of length time_between_turns
func next_turn():
	new_turn.emit()
	for a in agents:
		if is_instance_valid(a): a.run()
	print("ON NEXT TURN")
	print(turn_timer.wait_time)
	print(Settings.time_between_updates)
	print(Settings.speed_scale)
	print(Settings.base_game_length)
	progress += (Settings.time_between_updates / Settings.speed_scale) / Settings.base_game_length
	
func new_corbac():
	if randf_range(0, 1) <= Settings.birds_per_turn:
		var oiseau_instance = PIAF.instantiate()
		oiseau_instance.add_to_group("birds")
		add_child(oiseau_instance)

func end():
	#print("FINI")
	#print("------------------------------------------------------\n")
	turn_timer.stop()
	get_tree().change_scene_to_file("res://src/scenes/end/End.tscn")
	#get_tree().paused = true
	emit_signal("game_ended", 0)
