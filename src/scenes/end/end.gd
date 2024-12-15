extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$TextureRect.texture= Gamemaster.current_level_data["map"]
	#Oui c'est fait a la main. Non vous n'allez pas me juger.
	$MarginContainer/VBoxContainer/HBoxContainer/freeze.text = "Freeze : " + str(Stats.spells_used["Freeze"])
	$MarginContainer/VBoxContainer/HBoxContainer/poly.text = "Polymorph : " + str(Stats.spells_used["Polymorph"])
	$MarginContainer/VBoxContainer/HBoxContainer/tele.text = "Telekinesis : " + str(Stats.spells_used["Telekinesis"])

	$MarginContainer/VBoxContainer/HBoxContainer2/Default.text = "Naive : " + str(Stats.candy_per_strategy["StudentStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/Time.text = "Time : " + str(Stats.candy_per_strategy["CandyByTimeStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/LoneWolf.text = "LoneWolf : " + str(Stats.candy_per_strategy["LoneWolfStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/EscapeTeach.text = "EscapeTeacher : " + str(Stats.candy_per_strategy["EscapeTeacherStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/Duo.text = "TwoByTwo : " + str(Stats.candy_per_strategy["TwoByTwoStrategy"])

	#Commented until tom pushes

	var naive:String = "null data"
	var time:String = "null data"
	var lone:String = "null data"
	var escape:String = "null data"
	var duo:String = "null data"

	if Gamemaster.students_by_strategy["StudentStrategy"] != 0:
		naive = str(Stats.candy_per_strategy["StudentStrategy"] / Gamemaster.students_by_strategy["StudentStrategy"])
	if Gamemaster.students_by_strategy["CandyByTimeStrategy"] != 0:
		time = str(Stats.candy_per_strategy["CandyByTimeStrategy"] / Gamemaster.students_by_strategy["CandyByTimeStrategy"])
	if Gamemaster.students_by_strategy["LoneWolfStrategy"] != 0:
		lone = str(Stats.candy_per_strategy["LoneWolfStrategy"] / Gamemaster.students_by_strategy["LoneWolfStrategy"])
	if Gamemaster.students_by_strategy["EscapeTeacherStrategy"] != 0:
		escape = str(Stats.candy_per_strategy["EscapeTeacherStrategy"] / Gamemaster.students_by_strategy["EscapeTeacherStrategy"])
	if Gamemaster.students_by_strategy["TwoByTwoStrategy"] != 0:
		duo = str(Stats.candy_per_strategy["TwoByTwoStrategy"] / Gamemaster.students_by_strategy["TwoByTwoStrategy"])

	$MarginContainer/VBoxContainer/HBoxContainer3/Default.text = "Naive : " + naive
	$MarginContainer/VBoxContainer/HBoxContainer3/Time.text = "Time : " + time
	$MarginContainer/VBoxContainer/HBoxContainer3/LoneWolf.text = "LoneWolf : " + lone
	$MarginContainer/VBoxContainer/HBoxContainer3/EscapeTeach.text = "EscapeTeacher : " + escape
	$MarginContainer/VBoxContainer/HBoxContainer3/Duo.text = "TwoByTwo : " + duo
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/menu/Menu.tscn")
