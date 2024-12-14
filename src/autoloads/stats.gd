extends Node


#Remplir cette liste comme ca : StudentName(string) : numCandy(int)
#nb de bobons recup par chaque student
var candy_per_student:Dictionary = {} 

#nb de bonbons recup pour chaque strat
var candy_per_strategy:Dictionary = {
	"StudentStrategy" : 0,
	"CandyByTimeStrategy" : 0,
	"LoneWolfStrategy" : 0,
	"EscapeTeacherStrategy" : 0,
	"TwoByTwoStrategy" : 0
}

#nb de fois chaque spell est utilisé
var spells_used:Dictionary = {
	"Telekinesis" : 0,
	"Polymorph" : 0,
	"Freeze" : 0
}

func increase_stats(brain:Brain):
	#add to candy_by_student
	var student_name = str(brain.get_parent().name)
	if student_name not in candy_per_student:
		candy_per_student[student_name] = 0
	candy_per_student[student_name] += 1
	
	#add to candy_by_strategy
	var strat = brain.getStrategy()
	if strat not in candy_per_strategy:
		candy_per_strategy[strat] = 0
	candy_per_strategy[strat] += 1
	
	print(candy_per_strategy)
