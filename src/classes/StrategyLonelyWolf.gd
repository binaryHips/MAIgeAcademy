extends StudentStrategy
class_name LonelyWolfStrategy

func _decideGoal(brain:Brain, percept:Dictionary):
	match brain.states[0]:
		"idle":
			var studentsSearchingCandies = percept["students_by_distance"].filter(func(student):student.has_state("goToCandy"))
			#Si la moitié des students autour vont chercher un bonbon
			if(studentsSearchingCandies.size() >= percept["students_by_distance"].size()/2): 
				super.decideGoToCandy(brain, percept)
		"goToCandy":
			if percept["candies_by_distance"].size() == 0:
				super.decideGoBackToPlace(brain, percept)
		"goBackToSpace":
			super.decideIdle(brain, percept)

func get_class_name():
	return "LonelyWolfStrategy"
