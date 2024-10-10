extends Brain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	speed = 1000.0
	#getPathPoints()
	#pointProche(get_parent().position)
	#goProche()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	goProche()
	#pass

func getPathPoints():
	#print(get_parent())
	#print(get_parent().get_parent())
	var path = body.get_node("../Map/Path2D")
	var courbe = path.curve
	var points = []
	for i in range(courbe.get_point_count()):
		points.push_back(courbe.get_point_position(i))
	
	#print(points)
	return points

func pointProche(position):
	var points = getPathPoints()
	var minDistance = position.distance_to(points[0])
	var min = points[0]
	
	for i in range(len(points)):
		var dist = points[i].distance_to(position)
		if(dist < minDistance && minDistance < 20):
			#print("Ouaf !")
			minDistance = dist
			min = points[i]    
		if(minDistance == 0 && i != len(points)-1):
			#print("Ouaf ?")
			minDistance = points[i+1].distance_to(position)
			min = points[i+1]
		if(i == len(points)-1):
			#print("Ouaf...")
			minDistance = points[0].distance_to(position)
			min = points[0]
	
	#print(position)
	#print(minDistance)
	#print(min)
	return min

	
func goProche():
	move_target = pointProche(body.global_position)

#func _see():
	#
	#var percept = {
		#"sheep_seen":false,
		#"is_inside":false
	#}
	#
	#for body in view.get_overlapping_bodies():
		#if body.is_in_group("dog"):
#
				#percept["dog_seen"] = true
	#
	#percept["is_inside"] = body in Gamemaster.world_state["sheep_in"]
	#
	#return percept
#
#
#func _act(percept):
	#print(states)
#
	#if has_state("idle"):
		#if not percept["dog_seen"] and not percept["is_inside"]:
			#override_state("runaway")
		#
		#move_target = body.global_position + Vector2(
			#randf_range(-50, 50),
			#randf_range(-50, 50),
		#)
