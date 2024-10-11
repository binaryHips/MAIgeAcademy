extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(
		get_global_mouse_position(),
		delta * 200.0
	)

func _ready() -> void:
	$MarginContainer/VBoxContainer/SheepText.text = "Number of sheep : " + str(Gamemaster.n_sheep)
	$MarginContainer/VBoxContainer/TurnText.text = "Number of rounds : " + str(Gamemaster.length_in_rounds)

func _on_sheep_num_value_changed(value: float) -> void:
	$MarginContainer/VBoxContainer/SheepText.text = "Number of sheep : " + str(value)
	Gamemaster.n_sheep = int(value)


func _on_turn_num_value_changed(value: float) -> void:
	$MarginContainer/VBoxContainer/TurnText.text = "Number of rounds : " + str(value)
	Gamemaster.length_in_rounds = int(value)
