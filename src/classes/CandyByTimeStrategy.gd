extends StudentStrategy
class_name CandyByTimeStrategy

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			if brain.timer.time_left < 1:
				brain.timer.stop()
				decideGoToCandy(brain, percept)
		"goToCandy":
			if brain.goals[0]["goal_check"].call(brain, percept):
				decideGoBackToPlace(brain, percept)
		"goBackToPlace":
			decideIdle(brain, percept)
			brain.timer.start(10)
		
func get_class_name():
	return "CandyByTimeStrategy"
