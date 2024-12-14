extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

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
	#$MarginContainer/VBoxContainer/HBoxContainer3/Default.text = "Naive : " + str(Stats.candy_per_strategy["StudentStrategy"]/Gamemaster.student_by_strategy["StudentStrategy"])
	#$MarginContainer/VBoxContainer/HBoxContainer3/Time.text = "Time : " + str(Stats.candy_per_strategy["CandyByTimeStrategy"]/Gamemaster.student_by_strategy["CandyByTimeStrategy"])
	#$MarginContainer/VBoxContainer/HBoxContainer3/LoneWolf.text = "LoneWolf : " + str(Stats.candy_per_strategy["LoneWolfStrategy"]/Gamemaster.student_by_strategy["LoneWolfStrategy"])
	#$MarginContainer/VBoxContainer/HBoxContainer3/EscapeTeach.text = "EscapeTeacher : " + str(Stats.candy_per_strategy["EscapeTeacherStrategy"]/Gamemaster.student_by_strategy["EscapeTeacherStrategy"])
	#$MarginContainer/VBoxContainer/HBoxContainer3/Duo.text = "TwoByTwo : " + str(Stats.candy_per_strategy["TwoByTwoStrategy"]/Gamemaster.student_by_strategy["TwoByTwoStrategy"])
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/menu/Menu.tscn")
