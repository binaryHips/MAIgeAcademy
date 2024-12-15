extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var candy_collected:int = Stats.candy_per_strategy["StudentStrategy"] + Stats.candy_per_strategy["CandyByTimeStrategy"] + Stats.candy_per_strategy["LoneWolfStrategy"] + Stats.candy_per_strategy["EscapeTeacherStrategy"] + Stats.candy_per_strategy["TwoByTwoStrategy"]
	var candy_left:int = Stats.candy_spawned - candy_collected

	$TextureRect.texture= Gamemaster.current_level_data["map"]
	
	print("Candy spawned : " + str(Stats.candy_spawned))
	print("Candy collected : " + str(candy_collected))
	print("Candy left : " + str(candy_left))

	$MarginContainer/VBoxContainer/HboxCandy/Candy.text = "Candy spawned : " + str(Stats.candy_spawned)
	$MarginContainer/VBoxContainer/HboxCandy/Left.text = "Candy Left : " + str(candy_left)

	#Oui c'est fait a la main. Non vous n'allez pas me juger.
	$MarginContainer/VBoxContainer/HBoxContainer/freeze.text = "Freeze : " + str(Stats.spells_used["Freeze"])
	$MarginContainer/VBoxContainer/HBoxContainer/poly.text = "Polymorph : " + str(Stats.spells_used["Polymorph"])
	$MarginContainer/VBoxContainer/HBoxContainer/tele.text = "Telekinesis : " + str(Stats.spells_used["Telekinesis"])

	$MarginContainer/VBoxContainer/HBoxContainer2/Default.text = "Naive : " + str(Stats.candy_per_strategy["StudentStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/Time.text = "Time : " + str(Stats.candy_per_strategy["CandyByTimeStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/LoneWolf.text = "LoneWolf : " + str(Stats.candy_per_strategy["LoneWolfStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/EscapeTeach.text = "EscapeTeacher : " + str(Stats.candy_per_strategy["EscapeTeacherStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer2/Duo.text = "TwoByTwo : " + str(Stats.candy_per_strategy["TwoByTwoStrategy"])


	$MarginContainer/VBoxContainer/HBoxContainer4/Default.text = "Naive : " + str(Gamemaster.students_by_strategy["StudentStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer4/Time.text = "Time : " + str(Gamemaster.students_by_strategy["CandyByTimeStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer4/LoneWolf.text = "LoneWolf : " + str(Gamemaster.students_by_strategy["LoneWolfStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer4/EscapeTeach.text = "EscapeTeacher : " + str(Gamemaster.students_by_strategy["EscapeTeacherStrategy"])
	$MarginContainer/VBoxContainer/HBoxContainer4/Duo.text = "TwoByTwo : " + str(Gamemaster.students_by_strategy["TwoByTwoStrategy"])

	var naive:String = "null data"
	var time:String = "null data"
	var lone:String = "null data"
	var escape:String = "null data"
	var duo:String = "null data"

	if Gamemaster.students_by_strategy["StudentStrategy"] != 0:
		naive = str(floor(float(Stats.candy_per_strategy["StudentStrategy"]) / Gamemaster.students_by_strategy["StudentStrategy"] * 100) / 100)
	if Gamemaster.students_by_strategy["CandyByTimeStrategy"] != 0:
		time = str(floor(float(Stats.candy_per_strategy["CandyByTimeStrategy"]) / Gamemaster.students_by_strategy["CandyByTimeStrategy"] * 100) / 100)
	if Gamemaster.students_by_strategy["LoneWolfStrategy"] != 0:
		lone = str(floor(float(Stats.candy_per_strategy["LoneWolfStrategy"]) / Gamemaster.students_by_strategy["LoneWolfStrategy"] * 100) / 100)
	if Gamemaster.students_by_strategy["EscapeTeacherStrategy"] != 0:
		escape = str(floor(float(Stats.candy_per_strategy["EscapeTeacherStrategy"]) / Gamemaster.students_by_strategy["EscapeTeacherStrategy"] * 100) / 100)
	if Gamemaster.students_by_strategy["TwoByTwoStrategy"] != 0:
		duo = str(floor(float(Stats.candy_per_strategy["TwoByTwoStrategy"]) / Gamemaster.students_by_strategy["TwoByTwoStrategy"] * 100) / 100)

	$MarginContainer/VBoxContainer/HBoxContainer3/Default.text = "Naive : " + naive
	$MarginContainer/VBoxContainer/HBoxContainer3/Time.text = "Time : " + time
	$MarginContainer/VBoxContainer/HBoxContainer3/LoneWolf.text = "LoneWolf : " + lone
	$MarginContainer/VBoxContainer/HBoxContainer3/EscapeTeach.text = "EscapeTeacher : " + escape
	$MarginContainer/VBoxContainer/HBoxContainer3/Duo.text = "TwoByTwo : " + duo
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/menu/Menu.tscn")
