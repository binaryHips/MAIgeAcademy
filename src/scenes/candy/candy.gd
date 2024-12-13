extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemaster.world_state["candies"].append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _exit_tree() -> void:
	Gamemaster.world_state["candies"].erase(self)
