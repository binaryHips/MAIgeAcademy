extends StudentStrategy
class_name LoneWolfStrategy

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			if !percept["candies_by_distance"].is_empty() && brain.attention_span <= 0:
				var students = brain.get_tree().get_nodes_in_group("student")
				var candyMinFocus = students.size()
				
				var focusCandy = percept["candies_by_distance"][0]
				for candy in percept["candies_by_distance"]:
					var currentCandyFocus = 0
					for student in students:
						if student.get_node("brain").goals[0]["move_target"] == candy.global_position:
							currentCandyFocus += 1
					if candyMinFocus > currentCandyFocus:
						candyMinFocus = currentCandyFocus
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
							Stats.increase_stats(brain)
							return true
						return false
				}
				brain.override_state("goToCandy")
				brain.override_goal(dico)
			
		"goToCandy":
			if percept["candies_by_distance"].size() == 0:
				super.decideGoBackToPlace(brain, percept)
		"goBackToSpace":
			super.decideIdle(brain, percept)

func get_class_name():
	return "LoneWolfStrategy"
