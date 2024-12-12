extends StudentStrategy
class_name CandyByTimeStrategy


func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle" :
			super.decideGoToCandy(brain, percept)
		"goToCandy":
			if percept["candies_by_distance"].size == 0:
				super.decideGoBackToPlace(brain, percept)
		"goBackToPlace":
			super.decideIdle(brain, percept)
			
func _act(brain:Brain, percept:Dictionary):
	if !brain.timer.is_stopped() && brain.timer.time_left == 0:
		_decideGoal(brain, percept)
		if(brain.has_state("goToCandy")):
			var brain_goal = brain.goals.filter(func(dico):dico["name"] == "goToCandy")
			#fonction pour bouger vers le bonbon
		
func get_class_name():
	return "CandyByTimeStrategy"
