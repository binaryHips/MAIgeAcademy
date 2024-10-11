extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for body in get_overlapping_bodies():
		if body.is_in_group("sheep"):
			Gamemaster.world_state["sheep_in"].append(body)
			

func _on_body_entered(body: Node2D) -> void:
	Gamemaster.world_state["sheep_in"].append(body)

func _on_body_exited(body: Node2D) -> void:
	Gamemaster.world_state["sheep_in"].erase(body)
