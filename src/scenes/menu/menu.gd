extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_sheep_num_value_changed(value: float) -> void:
	$MarginContainer/VBoxContainer/SheepText.text = "Number of sheep : " + str(value)


func _on_turn_num_value_changed(value: float) -> void:
	$MarginContainer/VBoxContainer/TurnText.text = "Number of rounds : " + str(value)
	Gamemaster.length_in_rounds = value
