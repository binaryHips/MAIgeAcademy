extends Control


func _ready():
	$Panel.position = Vector2(0, -100)

func set_time(time:float):
	$Panel/time.text = "[center]" + str(time)
	

func _on_h_slider_value_changed(value: float) -> void:
	
	$Panel/VBoxContainer/turn_time.text = "Turn time (" + str(value) + "s)"
	Gamemaster.time_between_turns = value

var tween:Tween
func _on_mouse_entered() -> void:
	
	tween = get_tree().create_tween()
	tween.tween_property(
		$Panel,
		"position",
		Vector2(0, -100),
		0.6
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	
	tween.play()


func _on_mouse_exited() -> void:
	
	tween = get_tree().create_tween()
	tween.tween_property(
		$Panel,
		"position",
		Vector2(0, 0),
		0.6
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.play()
	
