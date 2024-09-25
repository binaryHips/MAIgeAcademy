extends Brain

@onready var view:Area2D = get_node("../view")

var dir_view:Vector2
var is_inside := true
func _see():
	
	var percept = {
		"dog_seen":false,
		"is_inside":is_inside
	}
	
	if move_target:
		dir_view = move_target - get_parent().global_position
		
	
	for body in view.get_overlapping_bodies():
		if body.is_in_group("dog"):
			if dir_view.dot( body.global_position - get_parent().global_position ):
				percept["dog_seen"] = true
	
func _act(percept):
	
	if not percept["dog_seen"] and not percept["is_inside"]:
		add_state("runaway")
