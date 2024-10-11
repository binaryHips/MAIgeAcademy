extends Node2D


func _ready() -> void:
	Gamemaster.main_scene = self
	




func on_new_round():
	var time_between_rounds = Gamemaster.time_between_turns * Gamemaster.turn_order.size()
	
