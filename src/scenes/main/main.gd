extends Node2D

const SHEEP = preload("res://src/scenes/sheep/sheep.tscn")

@export var sky_colors:Gradient
var col:Color
func _ready() -> void:
	Gamemaster.main_scene = self
	Gamemaster.new_round.connect(on_new_round)
	Gamemaster.start_game()
	col = sky_colors.sample(0.0)
	$ColorRect.material.set_shader_parameter("color", col)
	
	for k in Settings.n_sheep:
		var sheep := SHEEP.instantiate()
		add_child(sheep)
		sheep.position = Vector2i(
			randi_range(-100, 100),
			randi_range(-100, 100)
		)

	
func on_new_round(curr_round:int):
	if not sky_colors: return
	var time_between_rounds = Settings.time_between_turns * Gamemaster.turn_order.size()
	
	var fac = min(1.0, 1.0 / Settings.length_in_rounds * curr_round + 0.0001)
	
	print("FAC "  ,fac)
	$CanvasLayer/UI.set_time(fac)
	
	var newcol:Color = sky_colors.sample(
		fac
	)
	var tween = get_tree().create_tween()
	
	tween.tween_method(
		change_col,
			col,
			newcol,
			time_between_rounds
		)

	col = newcol
	
	tween.play()
	#$ColorRect.material.set_shader_parameter("color", col)
	
func change_col(col): 
	$ColorRect.material.set_shader_parameter("color", col)
