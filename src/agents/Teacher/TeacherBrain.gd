extends Brain

var current_target:Brain
@onready var range:Area2D = get_node("../Range")
@onready var contact:Area2D = get_node("../Contact")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_register()
	speed = Settings.teacher_speed
	add_state("teach")
	add_action("walk_and_cast_freeze",
		#Faudrait recup et utiliser les fonctions d'Andrew
		func():
			body.global_position += body.global_position.direction_to(current_target.body.global_position) * speed
			if current_target.body in range.get_overlapping_bodies():
				body.freeze()
				#send_event(current_target,{})
				current_target.add_state("comeback")
				override_state("teach")
	)
	add_action("walk_and_cast_transform",
		func():
			body.global_position += body.global_position.direction_to(current_target.body.global_position) * speed
			if current_target.body in range.get_overlapping_bodies():
				body.polymorph()
				#send_event(current_target,{})
				current_target.add_state("comeback")
				override_state("teach")
	)
	add_action("walk_and_cast_teleport",
		func():
			body.global_position += body.global_position.direction_to(current_target.body.global_position) * speed
			if current_target.body in contact.get_overlapping_bodies():
				body.telekinesis()
				#send_event(current_target,{})
				current_target.add_state("comeback")
				override_state("teach")
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	body.global_position += body.global_position.direction_to(Vector2(250,0)) * speed

func _register():
	body.set_meta("brain",self)
	pass

func _see():
	var percept = {"student": []}
	for element in $"../Vision".get_overlapping_bodies():
		percept["student"].push_back(element)
	return percept
	
func _act(percept):
	if has_state("teach"):
		body.wait()
		# Faudrait détecter si les élèves écoutent ou vont chercher des bonbons
		if !percept["student"].is_empty() and current_target.has_state("distracted"):
			override_state("cast")
	
	elif has_state("cast"):
		if is_instance_valid(current_target):
			if (
				not current_target.has_state("comeback")
				and current_target.has_state("distracted")
			):
				var spell:int = randi_range(0,2)
				if spell == 0:
					#execute_action("walk_and_cast_freeze")
					return
				elif spell == 1:
					#execute_action("walk_and_cast_transform)
					return
				else:
					#execute_action("walk_and_cast_teleport")
					return
			else:
				current_target = null
		for e in percept["student"]:
			var student_brain:Brain = e.get_meta("brain")
			if (
				not student_brain.has_state("comeback")
				and student_brain.has_state("distracted")
			):
				var spell:int = randi_range(0,2)
				current_target = student_brain
				if spell == 0:
					#execute_action("walk_and_cast_freeze")
					return
				elif spell == 1:
					#execute_action("walk_and_cast_transform)
					return
				else:
					#execute_action("walk_and_cast_teleport")
					return
			else:
				override_state("teach")
	pass
