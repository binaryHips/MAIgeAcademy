extends Control


var levels = [
	
	{
		"index": 0,
		"name": "recess",
		"scene": preload("res://src/levels/level0/Level0.tscn"),
		"map": preload("res://resources/images/coursMagie.png"),
		"max_students": 13
	},
	{
		"index": 1,
		"name": "snow recess",
		"scene": preload("res://src/levels/level0/Level1.tscn"),
		"map": preload("res://resources/images/cour_enneigee.png"),
		"max_students": 15
	},
	{
		"index": 2,
		"name": "class outside!",
		"scene": preload("res://src/levels/level0/Level2.tscn"),
		"map": preload("res://resources/images/coursMagie.png"),
		"max_students": 13
	},
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_level():
	Gamemaster.current_level_data = levels[current_selected_level]
	$"../VBoxContainer".update_values()
	$level_name.text = "[center]" + Gamemaster.current_level_data["name"]
	$Panel/TextureRect.texture = Gamemaster.current_level_data["map"]

var current_selected_level:int = 0
func _on_next_level_pressed() -> void:
	current_selected_level = (current_selected_level+1) % levels.size()
	$"../../../sonMenu2".play()
	update_level()

func _on_previous_level_pressed() -> void:
	current_selected_level = (current_selected_level-1 +levels.size()) % levels.size()
	$"../../../sonMenu2".play()
	update_level()
