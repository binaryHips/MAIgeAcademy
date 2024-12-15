extends Node2D
class_name Level

@export var agents:Array[Node2D]
@export var candy_scene:PackedScene = preload("res://src/scenes/candy/candy.tscn")
#@export var bench_scene:PackedScene = preload("res://src/scenes/bench/bench.tscn")
@export var student_scene:PackedScene = preload("res://src/agents/student/student.tscn")
var candy_sprites:Array[Texture2D] = [preload("res://resources/images/bonbon/bonbon1.png"),preload("res://resources/images/bonbon/bonbon2.png"),preload("res://resources/images/bonbon/bonbon3.tres")]
var t:Timer
var spawn_count

var number_of_students:int = 10
var position_benches:Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for bench in get_tree().get_nodes_in_group("benches"): position_benches.push_back(bench.global_position)
	
	for i in range(position_benches.size()):
		
		random_spawn_student_on_bench()
	
	t = Timer.new()
	t.wait_time = 1*Settings.speed_scale
	#t.timeout.connect(les_bonbons)
	t.timeout.connect(Gamemaster.new_corbac)
	add_child(t)
	t.start()
	
	setup_agents()
	

func setup_agents():
	Gamemaster.agents.clear()
	#print(agents)
	for a in agents:
		#print(a)
		Gamemaster.agents.append(
			a.get_meta("brain")
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for bird in get_tree().get_nodes_in_group("birds"):
		if randf_range(0, 1)*Settings.speed_scale <= Settings.candy_chance && bird.collisionCandy.get_overlapping_bodies().is_empty():
			spawn_candy(Vector2(bird.global_position.x+2, bird.global_position.y+33))
	pass


func les_bonbons():
	spawn_count = randf_range(2,5)
	for i in range(spawn_count):
		random_spawn_candy()
		
func spawn_candy(positionCandy):
	if positionCandy.x >= -400 && positionCandy.x <= 400 && positionCandy.y >= -400 && positionCandy.y <= 400:
		var candy = candy_scene.instantiate()
		var random_sprite =  randi() % candy_sprites.size()
		candy.get_node("Sprite2D").texture = candy_sprites[random_sprite]
		candy.position = positionCandy
		add_child(candy)
		Stats.candy_spawned += 1

func random_spawn_candy():
	var random_candy = candy_scene.instantiate()
	var random_sprite =  randi() % candy_sprites.size()
	random_candy.get_node("Sprite2D").texture = candy_sprites[random_sprite]
	var random_x = randf_range(-400,400)
	var random_y = randf_range(-400,400)
	
	if (random_x >= -300 && random_x <= -100 && random_y <= 350 && random_y >= 225) || (random_x >= 25 && random_x <= 225 && random_y <= -50 && random_y >= -150):
		print("recalcul de position bonbon")
		random_x = randf_range(0,400)
		random_y = randf_range(0,400)
	random_candy.position = Vector2(random_x,random_y)
	add_child(random_candy)
	Stats.candy_spawned += 1
	
func filter_strat_nulle(stratsDico):
	for elem in stratsDico.keys():
		if stratsDico[elem] == 0:
			stratsDico.erase(elem)

func random_spawn_student_on_bench():
	print(Gamemaster.students_by_strategy)
	var convertStringStrat = {"StudentStrategy" : StudentStrategy, "CandyByTimeStrategy" : CandyByTimeStrategy, "LoneWolfStrategy" : LoneWolfStrategy, "EscapeTeacherStrategy" : EscapeTeacherStrategy, "TwoByTwoStrategy" : TwoByTwoStrategy}
	var bench_choice = position_benches.pick_random()
	position_benches.erase(bench_choice)
	var spawned_student = student_scene.instantiate()
	spawned_student.global_position = bench_choice
	var countdown_strategy = Gamemaster.students_by_strategy.duplicate(true)
	filter_strat_nulle(countdown_strategy)
	var strategies = countdown_strategy.keys()
	var random_strat = strategies.pick_random()
	countdown_strategy[random_strat] -= 1
	
	spawned_student.get_node("brain").strategy = convertStringStrat[random_strat].new()
	add_child(spawned_student)
	agents.push_back(spawned_student)
