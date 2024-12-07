extends Brain

@export var strategy:StudentStrategy

var attention_span:float = 1.0;

var base_pos:Vector2

# Called when the node enters the scene tree for the first time.
func _setup():
	base_pos = body.global_position

func _see():
	var percept = {
		"distance_to_teacher": 99999.0,
		"position_of_teacher": Vector2(0, 0),
		"candies_by_distance": []
	}
	
	percept["distance_to_teacher"] = body.global_position.distance_to(Gamemaster.world_state["teacher"].global_position)
	
	percept["position_of_teacher"] = Gamemaster.world_state["teacher"].global_position
	
	percept["candies_by_distance"] = Gamemaster.world_state["candies"].duplicate()
	
	percept["candies_by_distance"].sort_custom(
		func (a, b):
			return (
				body.global_position.distance_squared_to(a)
				<= body.global_position.distance_squared_to(b)
			)
	)
	return percept

func _parse_event(event:Dictionary):
	strategy._parse
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
