extends Brain

@export var strategy:StudentStrategy

var ATTENTION_SPAN_DECREASE:float = 0.1
var attention_span:float = 1.0;

var base_pos:Vector2

# Called when the node enters the scene tree for the first time.
func _setup():
	base_pos = body.global_position
	ATTENTION_SPAN_DECREASE = randf_range(0.1, 0.2)
	

func _see():
	var percept = {
		"distance_to_teacher": 99999.0,
		"position_of_teacher": Vector2(0, 0),
		"candies_by_distance": [],
		"students_by_distance": []
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

func _parse_event(event:Dictionary):
	strategy._parse(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attention_span = max(0.0, attention_span - delta * ATTENTION_SPAN_DECREASE)
	
func freeze():
	body.freeze()
	# actions quand il est freeze
