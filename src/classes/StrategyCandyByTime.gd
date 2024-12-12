extends StudentStrategy
class_name CandyByTimeStrategy

var timerNode:Node

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle" :
			await timerNode.get_tree().create_timer(10.0).timeout
			print("fin d'attente")
			super.decideGoToCandy(brain, percept)
		"goToCandy":
			if percept["candies_by_distance"].size == 0:
				super.decideGoBackToPlace(brain, percept)
		"goBackToPlace":
			super.decideIdle(brain, percept)
			
func _act(brain:Brain, percept:Dictionary):
	if(brain.has_state("goToCandy")):
		var brain_goal = brain.goals.filter(func(dico):dico["name"] == "goToCandy")
		#fonction pour bouger vers le bonbon
		
func get_class_name():
	return "CandyByTimeStrategy"
