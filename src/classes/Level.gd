extends Node2D
class_name Level

@export var agents:Array[Node2D]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
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
