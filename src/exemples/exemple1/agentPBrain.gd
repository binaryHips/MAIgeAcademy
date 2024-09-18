extends Brain

@onready var visionRange : Area2D = get_node('../VisionRange')
@onready var parent = get_parent()
@export var mvSpeed = 20
var physics_delta:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	physics_delta = delta
	parent.move_and_slide()
	
		
func _see():
	var seen = {"cibles":[]}
	var contact := visionRange.get_overlapping_bodies()
	var targetPos
	for i in contact.size():
		if contact[i] != parent:
			seen["cibles"].append(contact[i])
	return seen

func _act(percept):
	if(!percept.cibles.is_empty()):
		var target = percept.cibles[0]
		parent.velocity = (target.position - parent.position).normalized() * mvSpeed
	else:
		print(physics_delta)
		
		parent.velocity = parent.velocity.move_toward(Vector2.ZERO, physics_delta * 5)
