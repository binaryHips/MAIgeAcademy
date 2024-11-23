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

func _ready(): # DONT OVERRIDE IT, USE _setup()
	body.set_meta("brain", self)

func _setup():
	pass


func run():
	parse_events()
	_act(_see())
	move()
	

func _see():
	pass
	
func _act(percept):
	pass

func move():
	#print(move_target)
	if move_target:
		
		var tween = get_tree().create_tween()
		tween.tween_property(body,
		"global_position",
		body.global_position.move_toward(move_target, speed),
		Settings.time_between_turns
		).set_trans(Tween.TRANS_SINE)
		tween.play()

func parse_events():
	while !event_queue.is_empty():
		_parse_event(event_queue.pop_back())


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
	agent.die()
	
func die():
	#Gamemaster.turn_order.erase(self)
	Gamemaster.turn_order = Gamemaster.turn_order.filter(
		func (a) : return not (a == self)
		)
	body.queue_free()
	print("rip")


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
