extends Brain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_register()
	speed = Settings.dog_speed
	add_state("patrol")

func _register():
	body.set_meta("brain", self)
	
	if Settings.intertwine_dog_turns:
		(
			func ():
				for i in range(Gamemaster.turn_order.size()-1, 0, -1):
					Gamemaster.turn_order.insert(i, self)
					print("TO", Gamemaster.turn_order)
				Gamemaster.turn_order.append(self)
		).call_deferred()
	else:
		Gamemaster.turn_order.append(self)

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
		#print(percept)
		if !percept["sheep"].is_empty():
			override_state("bark")
			
			
	if has_state("bark"):
		for e in percept["sheep"]:
			if e in Gamemaster.world_state["sheep_in"]:
				override_state("patrol")
			else:
				var sheep_brain = e.get_meta("brain")
				if sheep_brain.has_state("runaway"):
					move_target = e.global_position+sheep_brain.move_target.limit_length(sheep_brain.speed) * 1.6
					if body.global_position.distance_to(move_target) < sheep_brain.speed+10:
						body.bark()
						send_event(sheep_brain,{"type": "bark", "from" : body.global_position})
						override_state("patrol")
			
	if has_state("idle"):
		if not percept["sheep_seen"] and not percept["is_inside"]:
			override_state("patrol")
		
		move_target = body.global_position + Vector2(
			randf_range(-50, 50),
			randf_range(-50, 50),
		)
