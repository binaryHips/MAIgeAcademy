extends Brain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	goProche()

func pointProche(position):
	#TODO : passer en coordonnées locales
	var path = body.get_node("../Map/Path2D")
	var courbe = path.curve
	var closest_offset = courbe.sample_baked(courbe.get_closest_offset(position)+speed)
	return closest_offset
	
func goProche():
	move_target = pointProche(body.global_position)
	#$"../Area2D".get_overlapping_bodies()
	#if body.is_in_group("sheep")
	
	
func _see():
	
	var percept = {
		"sheep_seen":false,
		"is_inside":false
	}
	for element in $"../Area2D".get_overlapping_bodies():
		if element.is_in_group("sheep"):

				percept["sheep_seen"] = true
	
	percept["is_inside"] = body in Gamemaster.world_state["sheep_in"]
	
	return percept


func _act(percept):
	print("Etat chien : ",states)

	if has_state("patrol"):
		
		if percept["sheep_seen"]:
			override_state("bark")
			move_target = $"../Area2D".get_overlapping_bodies().global_position
			
	if has_state("idle"):
		if not percept["sheep_seen"] and not percept["is_inside"]:
			override_state("patrol")
		
		move_target = body.global_position + Vector2(
			randf_range(-50, 50),
			randf_range(-50, 50),
		)
