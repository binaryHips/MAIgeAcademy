extends Brain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#getPathPoints()
	#pointProche(get_parent().position)
	#goProche()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	goProche()

func getPathPoints():
	print(get_parent())
	print(get_parent().get_parent())
	var path = get_parent().get_parent().get_node("Path2D")
	var courbe = path.curve
	var points = []
	for i in range(courbe.get_point_count()):
		points.push_back(courbe.get_point_position(i))
	
	print(points)
	return points

func pointProche(position):
	var points = getPathPoints()
	var minDistance = points[0].distance_to(position)
	var min = points[0]
	
	for i in range(len(points)):
		var dist = points[i].distance_to(position)
		if(dist < minDistance && min != points[i]):
			print("Ouaf !")
			minDistance = dist
			min = points[i]    
		if(minDistance == 0 && i != len(points)-1):
			print("Ouaf ?")
			minDistance = points[i+1].distance_to(position)
			min = points[i+1]
		if(i == len(points)-1):
			print("Ouaf...")
			minDistance = points[0].distance_to(position)
			min = points[0]
	
	print(position)
	print(minDistance)
	print(min)
	return min
	
func goProche():
	move_target = pointProche(get_parent().global_position)
