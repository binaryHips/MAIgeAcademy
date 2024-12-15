extends StudentStrategy
class_name TwoByTwoStrategy

func decideGoToCandy(brain:Brain, percept:Dictionary):
	if brain.student_mate == null:
		brain.strategy = StudentStrategy.new()
	elif brain.getStrategy() == "TwoByTwoStrategy" && brain.student_mate.attention_span <= 0 && !brain.student_mate.has_state("goBackToPlace"):
			var minDistCommune = 9999
			var focusCandy = percept["candies_by_distance"][0]
			for candy in percept["candies_by_distance"]:
				var candySelfDistance = candy.global_position.distance_to(brain.body.global_position)
				var candyMateDistance = candy.global_position.distance_to(brain.student_mate.body.global_position)
				var distCommune = candySelfDistance + candyMateDistance
				if distCommune < minDistCommune:
					minDistCommune = distCommune
					focusCandy = candy
			var dico = {
				"name": "goToCandy",
				"move_target": focusCandy.global_position,
				"time_remaining": -1,
				"goal_check": func(brain:Brain, percept:Dictionary) :
					if(!is_instance_valid(focusCandy)):
						return true
					var dist = brain.body.global_position.distance_to(focusCandy.global_position)
					if(dist <= 15.0):
						focusCandy.queue_free()
						if !Stats.added_candy_list.has(focusCandy):
							Stats.added_candy_list.append(focusCandy)
							Stats.increase_stats(brain)
						return true
					return false
			}
			brain.override_state("goToCandy")
			brain.override_goal(dico)

	elif !brain.student_mate == null && brain.student_mate.has_state("goToCandy"):
		var focusCandy = percept["candies_by_distance"][0]
		for candy in percept["candies_by_distance"]:
			if candy.global_position == brain.student_mate.goals[0]["move_target"]:
				focusCandy = candy
				break
		var dico = {
			"name": "goToCandy",
			"move_target": focusCandy.global_position,
			"time_remaining": -1,
			"goal_check": func(brain:Brain, percept:Dictionary) :
				if(!is_instance_valid(focusCandy)):
					return true
				var dist = brain.body.global_position.distance_to(focusCandy.global_position)
				if(dist <= 15.0):
					focusCandy.queue_free()
					if !Stats.added_candy_list.has(focusCandy):
						Stats.added_candy_list.append(focusCandy)
						Stats.increase_stats(brain)
					return true
				return false
		}
		brain.override_state("goToCandy")
		brain.override_goal(dico)
		
	elif !brain.student_mate == null && (brain.student_mate.has_state("idle") || brain.student_mate.is_frozen || brain.student_mate.is_polymorphed):
		decideGoBackToPlace(brain, percept)
	else:
		decideIdle(brain, percept)

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			brain.body.wait()
			if brain.attention_span <= 0 && !percept["candies_by_distance"].is_empty():
				decideGoToCandy(brain, percept)
		"goToCandy":
			brain.body.walk()
			if brain.student_mate.states[0] == "goBackToPlace" || percept["candies_by_distance"].is_empty():
				decideGoBackToPlace(brain, percept)
			else:
				decideGoToCandy(brain, percept)
		"goBackToPlace":
			brain.body.walk()
			decideIdle(brain, percept)
		
func get_class_name():
	return "TwoByTwoStrategy"
