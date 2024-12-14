extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/levels/level0/Level0.tscn")

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
