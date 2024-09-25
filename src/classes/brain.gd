extends Node
class_name Brain

@export var asynchronous:=false

## A list of strings that define state flags for the agent
var moving := false
var move_target:Vector2

@export var speed:float #distance by turn

@export var states:Array[String]


@onready var body:PhysicsBody2D = get_parent()


func _ready() -> void: 
	Gamemaster.turn_order.append(self)

func run():
	_act(_see())
	

func _see():
	pass
	
func _act(percept):
	pass

func move_towards():
	if move_target:
		get_parent().global_position = get_parent().global_position.move_toward(move_target, speed)


func add_state(state:String):
	if state not in states:
		states.append(state)

func remove_state(state:String):
	if state in states:
		states.erase(state)
