extends StudentStrategy
class_name StudentCandyByTime

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle" :
			if (brain.attention_span <= 0): #peut-être remplacer ça par un timer/wait
				brain.override_state("goToCandy")
				for i in range(percept["candies_by_distance"].size()):
					var candy = percept["candies_by_distance"][i]
					var dico = {
						"name": "goToCandy",
						"move_target": candy,
						"time_remaining": -1,
						"goal_check": func(percept:Dictionary) :
							if(!is_instance_valid(candy)):
								return true
							var dist = brain.body.global_position.distance_to(candy.global_position)
							if(dist <= 1.0):
								candy.queue_free()
								return true
							return false
					}
					brain.add_goal(dico)
		"goToCandy":
			if(percept["candies_by_distance"].size() == 0):
				brain.override_state("goBackToPlace")
				var dico = {
					"name": "goBackToPlace",
					"move_target": brain.base_pos,
					"time_remaining": -1,
					"goal_check": func(percept:Dictionary) :
						var dist = brain.body.global_position.distance_to(brain.base_pos)
						if(dist <= 1.0):
							return true
						return false
				}
				brain.override_goal(dico)
		"goBackToPlace":
			var dist = brain.body.global_position.distance_to(brain.base_pos)
			if(dist < 1):
				brain.override_state("idle")
				var dico = {
					"name": "idle",
					"move_target": null,
					"time_remaining": -1,
					"goal_check": true
				}
				brain.override_goal(dico)
			
func _act(brain:Brain, percept:Dictionary):
	if(brain.has_state("goToCandy")):
		var brain_goal = brain.goals.filter(func(dico):dico["name"] == "goToCandy")
		#fonction pour bouger vers le bonbon
