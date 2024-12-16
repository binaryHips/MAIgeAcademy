extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemaster.world_state["candies"].append(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _exit_tree() -> void:
	Gamemaster.world_state["candies"].erase(self)


func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		# oopsie
		Stats.candy_spawned -= 1
		queue_free()
