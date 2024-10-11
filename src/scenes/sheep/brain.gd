extends Brain

@onready var view:Area2D = get_node("../view")

var dir_view:Vector2

var count_return:int = 0

func _ready():
	register()
	speed = 40
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
			speed = 80
			override_state("return")
			count_return += 5
			

func _see():
	
	var percept = {
		"dog_seen":false,
		"is_inside":false
	}
	
	if move_target:
		dir_view = move_target - get_parent().global_position
		
	
	for body in view.get_overlapping_bodies():
		if body.is_in_group("dog"):
			if dir_view.dot( body.global_position - get_parent().global_position) > 0:
				percept["dog_seen"] = true
	
	percept["is_inside"] = body in Gamemaster.world_state["sheep_in"]
	
	return percept




func _act(percept):
	print(states)
	if has_state("runaway"):
		
		if percept["is_inside"]:
			override_state("idle")
			
		execute_action("escape_run")
		
	elif has_state("return"):
		if percept["is_inside"]:
			speed = 40
			count_return = 0
			override_state("idle")
			
		if count_return <= 0:
			override_state("idle")
		
		count_return -= 1

	elif has_state("idle"):
		if not percept["dog_seen"] and not percept["is_inside"]:
			override_state("runaway")
			
		execute_action("idle_walk")
