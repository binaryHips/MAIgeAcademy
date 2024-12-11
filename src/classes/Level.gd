extends Node2D
class_name Level

@export var agents:Array[Node2D]
@export var candy_scene:PackedScene = preload("res://src/scenes/candy/candy.tscn")
var candy_sprites:Array[Texture2D] = [preload("res://resources/images/bonbon/bonbon1.png"),preload("res://resources/images/bonbon/bonbon2.png"),preload("res://resources/images/bonbon/bonbon3.tres")]
var t:Timer
var spawn_count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t = Timer.new()
	t.wait_time = 5
	t.timeout.connect(les_bonbons)
	add_child(t)
	t.start()
	
	setup_agents()

func setup_agents():
	Gamemaster.agents.clear()
	for a in agents:
		Gamemaster.agents.append(
			a.get_meta("brain")
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func les_bonbons():
	spawn_count = randf_range(0,4)
	for i in range(spawn_count):
		random_spawn_candy()

func random_spawn_candy():
	var random_candy = candy_scene.instantiate()
	var random_sprite =  randi() % candy_sprites.size()
	random_candy.get_node("Sprite2D").texture = candy_sprites[random_sprite]
	var random_x = randf_range(-400,400)
	var random_y = randf_range(-400,400)
	random_candy.position = Vector2(random_x,random_y)
	add_child(random_candy)
