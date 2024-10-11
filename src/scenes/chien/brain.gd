extends Brain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	register()
	speed = 200.0
	add_state("patrol")

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
	
	var percept = {"sheep" : []}
	for element in $"../Area2D".get_overlapping_bodies():
		if element.is_in_group("sheep"):
			percept["sheep"].push_back(element)
			#percept["sheep"]["sheep_seen"] = true
			#percept["sheep"] = element
	
	print("Percept : ",percept)
	return percept


func _act(percept):
	print("Etat chien : ",states)

	if has_state("patrol"):
		body.patrol()
		if !percept["sheep"].is_empty():
			override_state("bark")
			
					
	if has_state("bark"):
		for e in percept["sheep"]:
			if e in Gamemaster.world_state["sheep_in"]:
				override_state("patrol")
			else:
				move_target = e.global_position * 1.3
				body.bark()
				send_event(e.get_meta("brain"),{"type": "bark", "from" : e.global_position * 1.3})
				override_state("patrol")
			
	if has_state("idle"):
		if not percept["sheep_seen"] and not percept["is_inside"]:
			override_state("patrol")
		
		move_target = body.global_position + Vector2(
			randf_range(-50, 50),
			randf_range(-50, 50),
		)
