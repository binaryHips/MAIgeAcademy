extends Control


var levels = [
	
	{
		"index": 0,
		"name": "class outside!",
		"map": preload("res://resources/images/coursMagie.png"),
		"max_students": 10
	},
	{
		"index": 1,
		"name": "snow recess",
		"map": preload("res://resources/images/cour_enneigee.png"),
		"max_students": 15
	}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var current_selected_level:int = 0
func _on_next_level_pressed() -> void:
	current_selected_level = (current_selected_level+1) % levels.size()


func _on_previous_level_pressed() -> void:
	pass # Replace with function body.
