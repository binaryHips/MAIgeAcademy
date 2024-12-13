extends Brain

@export var strategy:StudentStrategy = [StudentStrategy, CandyByTimeStrategy, LoneWolfStrategy].pick_random().new()


var ATTENTION_SPAN_DECREASE:float = 0.1
var attention_span:float = 1.0;
var timer = Timer.new()
var base_pos:Vector2

var is_frozen:bool = false
var freeze_duration:float = 2.0
var freeze_timer:Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _setup():
	
	base_pos = body.global_position
	ATTENTION_SPAN_DECREASE = randf_range(0.1, 0.2)

	#connect freeze_timer to on_freeze_timer_timeout
	add_child(freeze_timer)
	freeze_timer.connect("timeout", Callable(self, "_on_freeze_timer_timeout"))
	
	override_state("idle")
	var dico = {
			"name": "idle",
			"move_target": base_pos,
			"time_remaining": -1,
			"goal_check": true
		}
	override_goal(dico)
	if strategy.get_class_name() == "CandyByTimeStrategy":
		#print("début du timer")
		add_child(timer)
		timer.start(10.0)

func _see():
	var percept = {
		"distance_to_teacher": 99999.0,
		"position_of_teacher": Vector2(0, 0),
		"candies_by_distance": []
	}
	
	percept["distance_to_teacher"] = body.global_position.distance_to(Gamemaster.world_state["teacher"].body.global_position)
	
	percept["position_of_teacher"] = Gamemaster.world_state["teacher"].body.global_position
	
	percept["candies_by_distance"] = Gamemaster.world_state["candies"].duplicate()
	
	percept["candies_by_distance"].sort_custom(
		func (a, b):
			return (
				body.global_position.distance_squared_to(a.global_position)
				<= body.global_position.distance_squared_to(b.global_position)
			)
	)
	return percept
	
func _act(percept:Dictionary):
	#print(timer.time_left)
	if(has_state("frozen")):
		freeze()
	strategy._act(self, percept)
	#print(strategy.get_class_name(), " : ", states)

func _parse_event(event:Dictionary):
	strategy._parse(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attention_span = max(0.0, attention_span - delta * ATTENTION_SPAN_DECREASE)
	if is_frozen:
		move_target = body.global_position
	
func freeze():
	if !is_frozen:
		is_frozen = true
		body.freeze()
		move_target = body.global_position
		freeze_timer.start(freeze_duration)
	# actions quand il est freeze

func _on_freeze_timer_timeout():
	print("unfreeze")
	is_frozen = false
	body.unfreeze()
	
func getStrategy():
	return str(strategy)
