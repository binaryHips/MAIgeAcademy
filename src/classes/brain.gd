extends Node
class_name Brain


## A list of strings that define state flags for the agent
var position:Vector2
var states:Array[String]


func run():
	_act(_see())


func _see():
	pass
	

func _act(percept):
	pass


func _move():
	pass
