extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _physics_process(delta: float) -> void:
	pass




func swap_to_advanced():
	var tween:Tween = get_tree().create_tween()
	
	tween.tween_property(
		$Enclos,
		"global_position:y",
		500,
		1.5
	).set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer,
		"position:y",
		-225,
		0.6
	).set_trans(Tween.TRANS_CUBIC)
	
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer2,
		"position:y",
		145,0.8
	).set_delay(0.7).set_trans(Tween.TRANS_CUBIC)
	
	tween.play()
	
func swap_to_menu():
	$Enclos/doggo/Timer.start()
	var tween:Tween = get_tree().create_tween()
	
	tween.tween_property(
		$Enclos,
		"global_position:y",
		1301,
		1.5
	).set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer2,
		"position:y",
		460,
		0.6
	).set_trans(Tween.TRANS_CUBIC)
	
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer,
		"position:y",
		145,0.8
	).set_delay(0.7).set_trans(Tween.TRANS_CUBIC)
	
	tween.play()

func _ready() -> void:
	_on_sheep_num_value_changed(Settings.n_sheep)
	$MarginContainer/VBoxContainer/SheepNum.value = Settings.n_sheep
	_on_turn_num_value_changed(Settings.length_in_rounds)
	$MarginContainer/VBoxContainer/TurnNum.value = Settings.length_in_rounds
	
	_on_sheep_speed_value_changed(Settings.sheep_speed)
	$MarginContainer2/VBoxContainer/SheepSpeed.value = Settings.sheep_speed
	_on_dog_speed_value_changed(Settings.dog_speed)
	$MarginContainer2/VBoxContainer/DogSpeed.value = Settings.dog_speed
	$MarginContainer2/VBoxContainer/doggo_plays.button_pressed = Settings.intertwine_dog_turns

	var tween:Tween = get_tree().create_tween()
	tween.tween_method(
		change_blur,
			4.0,
			0.0,
			1.4
		).set_trans(Tween.TRANS_SINE)
	tween.play()
	
func _on_sheep_num_value_changed(value: float) -> void:
	$MarginContainer/VBoxContainer/SheepText.text = "Number of sheep : " + str(value)
	Settings.n_sheep = int(value)


func _on_turn_num_value_changed(value: float) -> void:
	$MarginContainer/VBoxContainer/TurnText.text = "Number of rounds : " + str(value)
	Settings.length_in_rounds = int(value)



func change_blur(v:float): 
	$ColorRect.material.set_shader_parameter("lod", v)


func _on_timer_timeout() -> void:
	pass


func _on_doggo_plays_toggled(toggled_on: bool) -> void:
	Settings.intertwine_dog_turns = toggled_on


func _on_sheep_speed_value_changed(value: float) -> void:
	Settings.sheep_speed = value
	$MarginContainer2/VBoxContainer/SheepText.text = "Sheep base speed : " + str(value)


func _on_dog_speed_value_changed(value: float) -> void:
	Settings.dog_speed = value
	$MarginContainer2/VBoxContainer/DogText.text = "Dog speed : " + str(value)


func _on_margin_container_mouse_entered() -> void:
	$sonMenu.play()

func _on_margin_container_2_mouse_entered() -> void:
	$sonMenu.play()
