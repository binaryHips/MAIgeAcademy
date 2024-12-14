extends Brain

@export var strategy:StudentStrategy = [StudentStrategy, CandyByTimeStrategy, LoneWolfStrategy, EscapeTeacherStrategy, TwoByTwoStrategy].pick_random().new()
var student_mate:Brain = null

var ATTENTION_SPAN_DECREASE:float = 0.1
var attention_span:float = 1.0;
var timer = Timer.new()
var base_pos:Vector2

var is_frozen:bool = false
var freeze_duration:float = 2.0
var freeze_timer:Timer = Timer.new()

var is_polymorphed:bool = false
var polymorph_duration:float = 5.0
var polymorph_timer:Timer = Timer.new()

var is_teleporting:bool = false
var teleport_duration:float = 0.5
var teleport_timer:Timer = Timer.new()


var previous_state:String = "goToCandy"

# Called when the node enters the scene tree for the first time.
func _setup():
	
	base_pos = body.global_position
	ATTENTION_SPAN_DECREASE = randf_range(0.1, 0.2)

	#connect freeze_timer to on_freeze_timer_timeout
	add_child(freeze_timer)
	freeze_timer.connect("timeout", Callable(self, "_on_freeze_timer_timeout"))

	#connect poly time
	add_child(polymorph_timer)
	polymorph_timer.connect("timeout", Callable(self, "_on_polymorph_timer_timeout"))

	#connect teleport time
	add_child(teleport_timer)
	teleport_timer.connect("timeout", Callable(self, "_on_teleport_timer_timeout"))
	
	override_state("idle")
	var dico = {
			"name": "idle",
			"move_target": base_pos,
			"time_remaining": -1,
			"goal_check": true
		}
	override_goal(dico)
	if strategy.get_class_name() == "CandyByTimeStrategy":
		#print("début du timer")
		add_child(timer)
		timer.start(2.0)
	if strategy.get_class_name() == "TwoByTwoStrategy":
		var students = get_tree().get_nodes_in_group("student")
		print(getStrategy())
		for student in students:
			if student.get_node("brain") != self && student.get_node("brain").getStrategy() == "TwoByTwoStrategy" && student_mate == null && student.get_node("brain").student_mate == null:
				student_mate = student.get_node("brain")
				student.get_node("brain").student_mate = self
		

func _see():
	var percept = {
		"distance_to_teacher": 99999.0,
		"position_of_teacher": Vector2(0, 0),
		"candies_by_distance": []
	}
	
	percept["distance_to_teacher"] = body.global_position.distance_to(Gamemaster.world_state["teacher"].body.global_position)
	
	percept["position_of_teacher"] = Gamemaster.world_state["teacher"].body.global_position
	
	percept["candies_by_distance"] = Gamemaster.world_state["candies"].duplicate()
	
	percept["candies_by_distance"].sort_custom(
		func (a, b):
			return (
				body.global_position.distance_squared_to(a.global_position)
				<= body.global_position.distance_squared_to(b.global_position)
			)
	)
	return percept
	
func _act(percept:Dictionary):
	#print(timer.time_left)
	if(has_state("frozen")):
		freeze()
		return
	if(has_state("polymorphed")):
		polymorph()	
		return
	if(has_state("teleporting")):
		teleport()
		return
	strategy._act(self, percept)
	#print(strategy.get_class_name(), " : ", states)

func _parse_event(event:Dictionary):
	strategy._parse(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attention_span = max(0.0, attention_span - delta * ATTENTION_SPAN_DECREASE)
	if is_frozen:
		move_target = body.global_position
	if is_polymorphed:
		move_target = base_pos
	if is_teleporting:
		move_target = body.global_position
	get_parent().custom_debug_msg = strategy.get_class_name() + "\nmate : " + str(student_mate)
	
func freeze():
	if !is_frozen:

		#print("freeze")

		is_frozen = true
		is_polymorphed = false
		is_teleporting = false

		body.freeze()
		move_target = body.global_position
		freeze_timer.start(freeze_duration)
	# actions quand il est freeze

func _on_freeze_timer_timeout():
	#print("unfreeze")
	is_frozen = false
	
	#remove_state("frozen") #but did not work
	override_state(previous_state)

	body.unfreeze()

func polymorph():
	if !is_polymorphed:

		#print("polymorph")

		is_polymorphed = true
		is_frozen = false
		is_teleporting = false

		body.polymorph()
		move_target = base_pos
		polymorph_timer.start(polymorph_duration)
	# actions quand il est polymorph

func _on_polymorph_timer_timeout():
	#print("unpolymorph")
	is_polymorphed = false

	#remove_state("polymorphed") # :(
	if body.global_position.distance_to(base_pos) > 1.0:
		attention_span = min(attention_span + 0.5, 1.0)
		strategy.decideIdle(self,_see())
	else : 
		override_state(previous_state)

	#body.unpolymorph() maybe later but for now unfreeze does the same thing
	body.unfreeze()

func teleport():
	if !is_teleporting:

		#print("teleport")

		is_teleporting = true
		is_frozen = false
		is_polymorphed = false

		body.teleport()
		move_target = base_pos
		teleport_timer.start(teleport_duration)

func _on_teleport_timer_timeout():

	#print("unteleport")
	is_teleporting = false
	
	teleport_timer.stop()

	body.global_position = base_pos

	attention_span = min(attention_span + 0.5, 1.0)
	strategy.decideIdle(self,_see())
	#print("goal : ", goals[0].name)
	
	body.wait()


func getStrategy():
	return strategy.get_class_name()
