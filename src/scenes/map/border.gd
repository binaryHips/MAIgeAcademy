extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Gamemaster.world_state["out_of_bounds"].append(body)
