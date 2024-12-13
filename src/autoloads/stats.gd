extends Node


#Remplir cette liste comme ca : StudentName(string) : numCandy(int)
#nb de bobons recup par chaque student
var candy_per_student:Dictionary = {} 

#nb de bonbons recup pour chaque strat
var candy_per_strategy:Dictionary = {
	"StudentStrategy" : 0,
	"CandyByTimeStrategy" : 0,
	"LoneWolfStrategy" : 0,
	"LeaveMeAloneStrategy" : 0,
	"TwoByTwoStrategy" : 0
}

#nb de fois chaque spell est utilisé
var spells_used:Dictionary = {
	"Telekinesis" : 0,
	"Polymorph" : 0,
	"Freeze" : 0
}
