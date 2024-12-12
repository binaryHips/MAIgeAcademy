extends Resource
class_name StudentStrategy

func decideGoToCandy(brain:Brain, percept:Dictionary):
	if percept["candies_by_distance"].size() != 0:
		brain.override_state("goToCandy")
		
		var candy = percept["candies_by_distance"][0]
		var dico = {
			"name": "goToCandy",
			"move_target": candy.global_position,
			"time_remaining": -1,
			"goal_check": func(brain:Brain, percept:Dictionary) :
				if(!is_instance_valid(candy)):
					return true
				var dist = brain.body.global_position.distance_to(candy.global_position)
				if(dist <= 15.0):
					print("CANDY EATEN")
					candy.queue_free()
					return true
				return false
		}
		brain.override_goal(dico)
	
func decideGoBackToPlace(brain:Brain, percept:Dictionary):
	brain.override_state("goBackToPlace")
	var dico = {
		"name": "goBackToPlace",
		"move_target": brain.base_pos,
		"time_remaining": -1,
		"goal_check": func(brain:Brain, percept:Dictionary) :
			var dist = brain.body.global_position.distance_to(brain.base_pos)
			if(dist <= 1.0):
				return true
			return false
	}
	brain.override_goal(dico)
	
func decideIdle(brain:Brain, percept:Dictionary):
	var dist = brain.body.global_position.distance_to(brain.base_pos)
	if(dist < 1):
		brain.override_state("idle")
		var dico = {
			"name": "idle",
			"move_target": brain.base_pos,
			"time_remaining": -1,
			"goal_check": null
		}
		brain.override_goal(dico)

func _decideGoal(brain:Brain, percept:Dictionary): #percept contient positionPlace + bonbonsAProximite
	match brain.states[0]:
		"idle" :
			if (brain.attention_span <= 0) or percept["candies_by_distance"].is_empty():
				#brain.body.walk()
				decideGoToCandy(brain, percept)
			else:
				
				decideIdle(brain, percept)
				
		"goToCandy":
			if(percept["candies_by_distance"].size() == 0):
				
				decideGoBackToPlace(brain, percept)
			else:
				decideGoToCandy(brain, percept)
				
		"goBackToPlace":
			#brain.body.walk()
			decideIdle(brain, percept)
	
func _act(brain:Brain, percept:Dictionary):
	_decideGoal(brain, percept)
	if brain.goals[0]["goal_check"] is Callable:
		if brain.goals[0]["goal_check"].call(brain, percept):
			brain.body.wait()
			brain.override_state("idle")
		else:
			brain.body.walk()
			brain.move_target = brain.goals[0]["move_target"]
