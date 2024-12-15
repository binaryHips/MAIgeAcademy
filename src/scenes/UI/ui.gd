extends Control

func _ready():
	$Panel.position = Vector2(0, -100)
	
func _process(delta: float) -> void:
	$ProgressBar.value = (Gamemaster.game_timer.wait_time - Gamemaster.game_timer.time_left) / Gamemaster.game_timer.wait_time

func _on_h_slider_value_changed(value: float) -> void:
	value = snapped(value, 0.001)
	$Panel/VBoxContainer/turn_time.text = "Speed (" + str(value) + "s)"
	Settings.update_speed(0.01 / value)

var tween:Tween
func _on_mouse_entered() -> void:

	
	tween = get_tree().create_tween()
	tween.tween_property(
		$Panel,
		"position",
		Vector2(0, 0),
		0.6
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.play()


func _on_mouse_exited() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(
		$Panel,
		"position",
		Vector2(0, -100),
		0.6
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	
	tween.play()
	


func _on_finished_presse() -> void:
	Gamemaster.end()
