extends Brain

var current_target:Brain
var current_spell:SpellResource
var base_pos:Vector2

@export var spells:Array[SpellResource]

# Called when the node enters the scene tree for the first time.
func _setup() -> void:
	#_register()
	base_pos = body.global_position
	
	Gamemaster.world_state["teacher"] = self
	
	add_state("teach")
	add_action("walk_and_cast_spell",
		func():
			move_target = current_target.body.global_position
			var distance = body.global_position.distance_to(current_target.body.global_position)
			body.walk()
			if distance <= current_spell.getRange():
				current_spell.useSpell(current_target,self)
				current_spell = null
	)
	add_action("walk_and_teach",
		func():
			body.walk()
			move_target = base_pos
			var distance = body.global_position.distance_to(base_pos)
			
			if distance <= 20 :
				body.default()
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
		if element.is_in_group("student") && element.get_meta("brain").has_state("goToCandy"):
			percept["student"].push_back(element)
	return percept
	
func _act(percept):
	if has_state("teach"):
		body.default()
		# Faudrait détecter si les élèves écoutent ou vont chercher des bonbons
		if !percept["student"].is_empty():
			override_state("cast")
		execute_action("walk_and_teach")
	
	elif has_state("cast"):
		for e in percept["student"]:
			var student_brain:Brain = e.get_meta("brain")
			if (
				not student_brain.has_state("goBackToPlace")
				and student_brain.has_state("goToCandy")
			):
				var current_distance = current_target.body.global_position.distance_to(body.global_position)
				var new_distance = student_brain.body.global_position.distance_to(body.global_position)
				if current_target == null && current_distance > new_distance :
					current_target = student_brain
				
		if is_instance_valid(current_target):
			if (
				not current_target.has_state("goBackToPlace")
				and current_target.has_state("goToCandy")
			):
				if current_spell == null:
					current_spell = spells.pick_random() 
				execute_action("walk_and_cast_spell")
			else:
				current_target = null
		
			#else:
				#override_state("teach")
	pass

func addMana(mana:int):
	pass
