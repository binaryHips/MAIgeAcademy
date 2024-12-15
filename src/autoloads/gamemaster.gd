extends Node

var world_state:Dictionary = {
	"candies": []
}

var main_scene:Node2D

var agents:Array[Brain] = []

const PIAF = preload("res://src/scenes/oiseau/oiseau.tscn")

var current_level_data := {}  #set from the menu
var students_by_strategy := {} #set from the menu

@onready var turn_timer:Timer = Timer.new()


@onready var game_timer:Timer = Timer.new()
var game_duration:float = 60.0

signal game_started
signal game_ended(result:int)

##WARNING Async!
signal new_round(num:int)
signal new_turn(player_idx:int)

func _ready() -> void:
	add_child(turn_timer)
	add_child(game_timer)
	game_timer.connect("timeout", Callable(self, "end"))
	start_game()

func start_game():
	agents.clear()
	#agents.assign(get_tree().get_nodes_in_group("agents"))
	print("----------------------------------")
	print("At the start of the Game : ")
	turn_timer.start()
	Settings.update_speed(0.001)
	turn_timer.wait_time = Settings.time_between_updates
	turn_timer.timeout.connect(next_turn)
	#game_timer.start(game_duration * Settings.speed_scale)
	emit_signal("game_started")

var round_count:int
## calls the next turn. By default, triggered by a timer of length time_between_turns
func next_turn():
	new_turn.emit()
	for a in agents:
		if is_instance_valid(a): a.run()
	
func new_corbac():
	if randf_range(0, 1) <= Settings.birds_per_turn:
		var oiseau_instance = PIAF.instantiate()
		oiseau_instance.add_to_group("birds")
		add_child(oiseau_instance)

func end():
	#print("FINI")
	#print("------------------------------------------------------\n")
	game_timer.stop()
	turn_timer.stop()
	get_tree().change_scene_to_file("res://src/scenes/end/End.tscn")
	#get_tree().paused = true
	emit_signal("game_ended", 0)
