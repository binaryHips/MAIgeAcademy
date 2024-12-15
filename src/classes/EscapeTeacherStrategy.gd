extends StudentStrategy
class_name EscapeTeacherStrategy


func decideGoToCandy(brain:Brain, percept:Dictionary):
	const corners = [Vector2(-400, 400), Vector2(400, 400), Vector2(-400, -400), Vector2(400, -400)]
	var maxDistanceCorner = Vector2(0, 0)
	for corner in corners:
		if percept["position_of_teacher"].distance_to(corner) > percept["position_of_teacher"].distance_to(maxDistanceCorner):
			maxDistanceCorner = corner
	brain.override_state("goToCandy")
	var dico = {
		"name": "goToCandy",
		"move_target": maxDistanceCorner,
		"time_remaining": -1,
		"goal_check": func(brain:Brain, percept:Dictionary) :
		var dist = brain.body.global_position.distance_to(maxDistanceCorner)
		if(dist <= 1.0):
			return true
		return false
	}
	brain.override_goal(dico)

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			if brain.attention_span <= 0:
				decideGoToCandy(brain, percept)
			
		"goToCandy":
			for candy in percept["candies_by_distance"]:
				if brain.body.global_position.distance_to(candy.global_position) < 15:
					print("CANDY EATEN")
					candy.queue_free()
					if !Stats.added_candy_list.has(candy):
						Stats.added_candy_list.append(candy)
						Stats.increase_stats(brain)
			decideGoToCandy(brain, percept)


func get_class_name():
	return "EscapeTeacherStrategy"
