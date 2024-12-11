extends Resource
class_name StudentStrategy

func decideGoToCandy(brain:Brain, percept:Dictionary):
	brain.override_state("goToCandy")
	
	var candy = percept["candies_by_distance"][0]
	var dico = {
		"name": "goToCandy",
		"move_target": candy.global_position,
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
	
func decideGoBackToPlace(brain:Brain, percept:Dictionary):
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
	
func decideIdle(brain:Brain, percept:Dictionary):
	var dist = brain.body.global_position.distance_to(brain.base_pos)
	if(dist < 1):
		brain.override_state("idle")
		var dico = {
			"name": "idle",
			"move_target": brain.base_pos,
			"time_remaining": -1,
			"goal_check": true
		}
		brain.override_goal(dico)

func _decideGoal(brain:Brain, percept:Dictionary): #percept contient positionPlace + bonbonsAProximite
	match brain.states[0]:
		"idle" :
			if (brain.attention_span <= 0):
				decideGoToCandy(brain, percept)
				
		"goToCandy":
			if(percept["candies_by_distance"].size() == 0):
				decideGoBackToPlace(brain, percept)
				
		"goBackToPlace":
			decideIdle(brain, percept)
	
func _act(brain:Brain, percept:Dictionary):
	_decideGoal(brain, percept)
	brain.move_target = brain.goals[0]["move_target"]
