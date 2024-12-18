extends StudentStrategy
class_name CandyByTimeStrategy

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			brain.body.wait()
			if brain.timer.time_left < 1 && brain.attention_span <= 0:
				brain.timer.stop()
				decideGoToCandy(brain, percept)
		"goToCandy":
			brain.body.walk()
			if brain.goals[0]["goal_check"] is Callable:
				if brain.goals[0]["goal_check"].call(brain, percept):
					decideGoBackToPlace(brain, percept)
		"goBackToPlace":
			brain.body.walk()
			decideIdle(brain, percept)
			brain.timer.start(2)
		
func get_class_name():
	return "CandyByTimeStrategy"
