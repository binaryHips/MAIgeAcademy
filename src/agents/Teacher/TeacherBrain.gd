extends Brain

var current_target:Brain
var current_spell:SpellResource
var base_pos:Vector2

@export var spells:Array[SpellResource]

# Called when the node enters the scene tree for the first time.
func _setup() -> void:
	#_register()
	print("setup teacher")
	base_pos = body.global_position
	
	Gamemaster.world_state["teacher"] = self
	
	override_state("teach")
	add_action("walk_and_cast_spell",
		func():
			#print("walk and cast spell")
			move_target = current_target.body.global_position
			var distance = body.global_position.distance_to(current_target.body.global_position)
			body.walk()
			if distance <= current_spell.getRange():
				print("range check")
				current_spell.useSpell(current_target,self)
				if current_spell.getName() != "teleport":
					current_spell.spawnScene(current_target.body,self.body)
				print("spell casted")
				current_spell = null
	)
	add_action("walk_and_teach",
		func():
			#print("walk and teach")
			body.walk()
			move_target = base_pos
			var distance = body.global_position.distance_to(base_pos)
			
			if distance <= 20 :
				#print("en position")
				body.wait()
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
	#print("see")
	var percept = {"student": []}
	for element in $"../Area2D".get_overlapping_bodies():
		#print("element : ",element)
		if element.is_in_group("student") && element.get_meta("brain").has_state("goToCandy"):
			#print("eleve : ",element)
			percept["student"].push_back(element)
	return percept
	
func _act(percept):
	#print("act")
	if has_state("teach"):
		#print("teach")
		body.wait()
		# Faudrait détecter si les élèves écoutent ou vont chercher des bonbons
		if !percept["student"].is_empty():
			override_state("cast")
		execute_action("walk_and_teach")
	
	elif has_state("cast"):
		#print("cast")
		for e in percept["student"]:
			#print(e)
			var student_brain:Brain = e.get_meta("brain")
			if (
				not student_brain.has_state("goBackToPlace")
				and student_brain.has_state("goToCandy")
			):
				var current_distance = e.global_position.distance_to(body.global_position)
				var new_distance = student_brain.body.global_position.distance_to(body.global_position)
				if current_target == null && current_distance >= new_distance :
					current_target = student_brain
					#print(current_target)
		#print(current_target)
		if is_instance_valid(current_target):
			if (
				not current_target.has_state("goBackToPlace")
				and current_target.has_state("goToCandy")
			):
				if current_spell == null:
					current_spell = spells.pick_random() 
					#print(current_spell.getName())
				execute_action("walk_and_cast_spell")
			else:
				current_target = null
		
			#else:
				#override_state("teach")
	pass

func addMana(mana:int):
	pass
