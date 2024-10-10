extends Brain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	speed = 10.0
	#getPathPoints()
	#pointProche(get_parent().position)
	#goProche()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	goProche()
	#pass

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
	var minDistance = position.distance_to(points[0])
	var min = points[0]

	for i in range(1, len(points)):
		var dist = position.distance_to(points[i])
		print("dist : ",dist)
		if dist < minDistance:
			minDistance = dist
			min = points[i]

	print(position)
	print(minDistance)
	print(min)
	return min

	
func goProche():
	move_target = pointProche(body.global_position)
