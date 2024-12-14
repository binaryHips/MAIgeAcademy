extends StudentStrategy
class_name TwoByTwoStrategy

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			if brain.attention_span <= 0 && brain.student_mate.attention_span <=0:
				var minDistCommune = 9999
				var focusCandy = percept["candies_by_distance"][0]
				for candy in percept["candies_by_distance"]:
					var candySelfDistance = candy.global_position.distance_to(brain.body.global_position)
					var candyMateDistance = candy.global_position.distance_of(brain.studen_mate.global_position)
					var distCommune = abs(candySelfDistance-candyMateDistance)
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
							return true
						return false
				}
				brain.override_state("goToCandy")
				brain.override_goal(dico)

			elif brain.student_mate.has_state("goToCandy"):
				var focusCandy = percept["candies_by_distance"][0]
				for candy in percept["candies_by_distance"]:
					if candy.global_position == brain.student_mate.goals[0]["move__target"]:
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
							return true
						return false
				}
				brain.override_state("goToCandy")
				brain.override_goal(dico)
			else:
				decideIdle(brain, percept)
		"goToCandy":
			if brain.student_mate.states[0] == "goBackToPlace":
				decideGoBackToPlace(brain, percept)
		"goBackToPlace":
			decideIdle(brain, percept)
		
func get_class_name():
	return "TwoByTwoStrategy"
