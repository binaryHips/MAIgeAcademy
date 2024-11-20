extends Brain

@onready var view:Area2D = get_node("../view")

var dir_view:Vector2

var count_return:int = 0
var out:bool = false

func _ready():
	_register()
	speed = Settings.sheep_speed
	override_state("idle")
	
	add_action("idle_walk" , 
		func():
			move_target = body.global_position + Vector2(
			randf_range(-50, 50),
			randf_range(-50, 50),
		)
	)
	
	add_action("escape_run" , func():
		move_target = body.global_position * 9999
	)

func _parse_event(event:Dictionary):
	
	match event["type"]:
		"bark":
			move_target = (body.global_position - event["from"]) * 999
			speed = Settings.sheep_speed * 1.8
			override_state("return")
			count_return += randi_range(3, 5)
			

func _see():
	
	var percept = {
		"dog_seen":false,
		"is_inside":false,
		"has_escaped":false,
	}
	
	if move_target:
		dir_view = move_target - get_parent().global_position
		
	
	for body in view.get_overlapping_bodies():
		if body.is_in_group("dog"):
			if dir_view.dot( body.global_position - get_parent().global_position) > 0:
				percept["dog_seen"] = true
	
	percept["is_inside"] = body in Gamemaster.world_state["sheep_in"]
	percept["has_escaped"] = body in Gamemaster.world_state["out_of_bounds"]

	return percept


func _act(percept):
	#print(states)
	if has_state("runaway"):
		#body.walk()
		if percept["is_inside"]:
			override_state("idle")
			
		if percept["has_escaped"]:
			die()
		execute_action("escape_run")
		
	elif has_state("return"):
		#body.walk()
		if percept["is_inside"]:
			speed = Settings.sheep_speed
			count_return = 0
			override_state("idle")
			execute_action("idle_walk")
			return
		
		elif count_return <= 0:
			override_state("runaway")
			execute_action("escape_run") #??
			return
		#print("COUNT RETURN ", count_return)
		count_return -= 1
		
	elif has_state("idle"):
		if not percept["dog_seen"] and not percept["is_inside"]:
			override_state("runaway")
			execute_action("escape_run")
		else:
			execute_action("idle_walk")

func move():
	#print(move_target)
	if move_target:
		var TRANS:int = Tween.TRANS_SINE
		if body in Gamemaster.world_state["sheep_in"]:
			out = false
			body.walk()
		else:
			if not out:
				#print("il sort de l'enclos")
				out = true
				body.jump()
				TRANS = Tween.TRANS_CIRC
			else:
				#print("il est dehors !!")
				body.walk()
		
		body.get_node("AnimatedSprite2D")
		var tween = get_tree().create_tween()
		tween.tween_property(body,
		"global_position",
		body.global_position.move_toward(move_target, speed),
		Settings.time_between_turns
		).set_trans(TRANS)
		tween.play()
		
		await body.get_node("AnimatedSprite2D").animation_finished
		body.wait()
