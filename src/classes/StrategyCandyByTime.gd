extends StudentStrategy
class_name CandyByTimeStrategy


func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle" :
			super.decideGoToCandy(brain, percept)
		"goToCandy":
			if percept["candies_by_distance"].size() == 0:
				super.decideGoBackToPlace(brain, percept)
		"goBackToPlace":
			super.decideIdle(brain, percept)
			if brain.has_state("idle"):
				brain.timer.start(10)
			
func _act(brain:Brain, percept:Dictionary):
	if !brain.timer.is_stopped() && brain.timer.time_left < 1:
		brain.timer.stop()
		_decideGoal(brain, percept)
		if brain.goals[0]["goal_check"] is Callable:
			if brain.goals[0]["goal_check"].call(brain, percept):
				brain.body.wait()
				brain.override_state("idle")
			else:
				brain.body.walk()
				brain.move_target = brain.goals[0]["move_target"]
		
func get_class_name():
	return "CandyByTimeStrategy"
