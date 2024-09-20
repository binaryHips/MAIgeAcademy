extends Node
class_name Brain

## A list of strings that define state flags for the agent
var moving := false
var move_target:Vector2

@export var speed:float #distance by turn

@export var states:Array[String]


@onready var body:PhysicsBody2D = get_parent()


func _ready() -> void: 
	Gamemaster.turn_order.append(self)

func _process(delta):
	run()

func run():
	_act(_see())
	

func _see():
	pass
	
func _act(percept):
	pass

func move_towards(pos: Vector2):
	move_target = pos
