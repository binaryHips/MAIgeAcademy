extends Brain

var current_target:Brain
var current_spell:SpellResource
var base_pos:Vector2

@export var spells:Array[SpellResource]

@onready var contact:Area2D = get_node("../Contact")

# Called when the node enters the scene tree for the first time.
func _setup() -> void:
	#_register()
	base_pos = body.global_position
	speed = Settings.teacher_speed
	add_state("teach")
	add_action("walk_and_cast_spell",
		func():
			move_target = current_target.body.global_position
			var distance = body.global_position.distance_to(current_target.body.global_position)
			
			if distance <= current_spell.getRange():
				current_spell.useSpell(current_target,self)
				current_spell = null
	)
	add_action("walk_and_teach",
		func():
			move_target = base_pos
			var distance = body.global_position.distance_to(base_pos)
			
			if distance <= 20 :
				pass
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#body.global_position += body.global_position.direction_to(Vector2(250,0)) * speed
	pass

#func _setup():
	#body.set_meta("brain",self)
	#pass

func _see():
	var percept = {"student": []}
	for element in $"../Area2D".get_overlapping_bodies():
		percept["student"].push_back(element)
	return percept
	
func _act(percept):
	if has_state("teach"):
		body.wait()
		# Faudrait détecter si les élèves écoutent ou vont chercher des bonbons
		if !percept["student"].is_empty() and current_target.has_state("distracted"):
			override_state("cast")
		execute_action("walk_and_teach")
	
	elif has_state("cast"):
		#go to current target
		if is_instance_valid(current_target):
			if (
				not current_target.has_state("comeback")
				and current_target.has_state("distracted")
			):
				if current_spell == null:
					current_spell = spells.pick_random() 
				execute_action("walk_and_cast_spell")
			else:
				current_target = null
		#check if there IS a target
		for e in percept["student"]:
			var student_brain:Brain = e.get_meta("brain")
			if (
				not student_brain.has_state("comeback")
				and student_brain.has_state("distracted")
			):
				current_target = student_brain
			else:
				override_state("teach")
	pass

func addMana(mana:int):
	pass
