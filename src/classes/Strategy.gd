extends Resource
class_name StudentStrategy



func _decideGoal(brain:Brain, percept:Dictionary): #percept contient positionPlace + bonbonsAProximite
	match brain.states[0]:
		"idle" :
			if (brain.attention_span <= 0):
				brain.override_state("goToCandy")
				var candy = percept["candies_by_distance"][0]
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
				brain.override_goal(dico)
		#"goToCandy":
			
			
	push_error("_decideGoal in strategy not implemented")
	
func _act(brain:Brain, percept:Dictionary):
	if(brain.has_state("idle")):
		
	push_error("_act in strategy not implemented")
