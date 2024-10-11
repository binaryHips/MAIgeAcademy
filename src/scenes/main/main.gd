extends Node2D


@export var sky_colors:Gradient
var col:Color
func _ready() -> void:
	Gamemaster.main_scene = self
	Gamemaster.new_round.connect(on_new_round)
	
	sky_colors.sample(0.1)
	on_new_round(0)


func on_new_round(curr_round:int):
	if not sky_colors: return
	var time_between_rounds = Gamemaster.time_between_turns * Gamemaster.turn_order.size()
	
	var fac = 1.0 / Gamemaster.length_in_rounds * curr_round
	
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
