extends Brain

@export var strategy:Strategy

var base_pos:Vector2

# Called when the node enters the scene tree for the first time.
func _setup():
	base_pos = body.global_position

func _see():
	var percept = {
		"distance_to_teacher": 99999.0,
		"candies_by_distance": []
		
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
