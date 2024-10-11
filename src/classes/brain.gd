extends Node
class_name Brain

@export var asynchronous:=false

## A list of strings that define state flags for the agent
var moving := false
var move_target:Vector2 #FIXME

## Event system
var event_queue:Array[Dictionary]

@export var speed:float #distance by turn

@export var states:Array[String]

@onready var body:PhysicsBody2D = get_parent()

var actions = {}


func _init() -> void: 
	Gamemaster.turn_order.append(self)

func run():
	parse_events()
	_act(_see())
	move()
	

func _see():
	pass
	
func _act(percept):
	pass

func move():
	print(move_target)
	if move_target:
		
		var tween = get_tree().create_tween()
		tween.tween_property(body,
		"global_position",
		body.global_position.move_toward(move_target, speed),
		Gamemaster.time_between_turns
		).set_trans(Tween.TRANS_ELASTIC)
		tween.play()

func parse_events():
	for evt in event_queue:
		_parse_event(evt)


func _parse_event(event:Dictionary):
	print ("EVENT PROCESSED: ", event)
	print("\n")
	

func has_state(state:String):
	return state in states;

func add_state(state:String):
	if state not in states:
		states.append(state)

func override_state(state:String):
	states = [state]

func remove_state(state:String):
	if state in states:
		states.erase(state)

static func send_event(agent:Brain, event:Dictionary):
	agent.event_queue.append(event)
	
func add_event(event:Dictionary):
	event_queue.append(event)

static func kill(agent:Brain):
	Gamemaster.turn_order.erase(agent)
	agent.queue_free()

func add_action(name:String , fun:Callable):
	actions[name] = fun

func initiate_actions(dic:Dictionary):
	actions = dic

func execute_action(name:String , args:Array = []):
	if(args.is_empty()):
			actions[name].call()
	else:
		actions[name].call(args)

func remove_action(name:String):
	actions.erase(name)
