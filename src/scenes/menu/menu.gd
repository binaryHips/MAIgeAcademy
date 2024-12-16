extends Control



func _on_start_pressed() -> void:
	Gamemaster.start_game()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _physics_process(delta: float) -> void:
	pass



func swap_to_advanced():
	var tween:Tween = get_tree().create_tween()
	
	tween.tween_property(
		$bg,
		"global_position:y",
		-708,
		1.5
	).set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer,
		"position:y",
		-500,
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
	var tween:Tween = get_tree().create_tween()
	
	tween.tween_property(
		$bg,
		"global_position:y",
		0,
		1.5
	).set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer2,
		"position:y",
		1100,
		0.6
	).set_trans(Tween.TRANS_CUBIC)
	
	tween.set_parallel()
	tween.tween_property(
		$MarginContainer,
		"position:y",
		198,0.8
	).set_delay(0.7).set_trans(Tween.TRANS_CUBIC)
	
	tween.play()

func _ready() -> void:
	
	$MarginContainer2/HBoxContainer/levelSelector.update_level()
	$MarginContainer2/HBoxContainer/VBoxContainer.update_values()
	
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




func _on_margin_container_mouse_entered() -> void:
	$sonMenu.play()

func _on_margin_container_2_mouse_entered() -> void:
	$sonMenu.play()


func _on_slider_teacher_value_changed(value: float) -> void:
	$MarginContainer2/HBoxContainer/VBoxContainer/teacher.text = "Teacher speed (" + str(value) + "x student's)"
	Settings.teacher_speed_factor = value
	Settings.teacher_speed = Settings.student_speed * Settings.teacher_speed_factor


func _on_slider_duration_value_changed(value: float) -> void:
	$MarginContainer2/HBoxContainer/VBoxContainer/duration.text = "Game duration (" + str(value) + "s)"
	Settings.max_candy = value


func _on_slider_candy_value_changed(value: float) -> void:
	$MarginContainer2/HBoxContainer/VBoxContainer/max_candy.text = "Max candy on ground (" + str(value) + ")"
	Settings.max_candy = value
