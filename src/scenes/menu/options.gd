extends VBoxContainer

@onready var sliders:Array[HSlider] = [$Naive/slider_naive, $Escape/slider_escape, $LoneWolf/slider_wolf, $CandyByTime/slider_candy_time, $Friend/slider_friend]

@onready var texts:Array[String] = [$Naive.text, $Escape.text, $LoneWolf.text, $CandyByTime.text, $Friend.text]


var is_dragging:Array[bool]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in len(sliders):
		
		is_dragging.append(false)
		sliders[i].drag_started.connect(
			func ():
				is_dragging[i] = true
		)
		sliders[i].drag_ended.connect(
			func (_a):
				is_dragging[i] = false
		)
		sliders[i].value_changed.connect(
			func (v:float):
				if is_dragging[i]: update_sliders(i)
		) 
	
	setup_sliders()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_sliders(just_modified:int):
	
	
	
	
	update_values()



func update_values():
	var strategies := ["StudentStrategy", "EscapeTeacherStrategy", "LoneWolfStrategy", "CandyByTimeStrategy", "TwoByTwoStrategy"]
	var total_n_students:int = Gamemaster.current_level_data["max_students"]
	var remaining_students := total_n_students
	var sum:float = 0
	for s in sliders:
		sum += s.value
	
	
	var sliders_sorted = range(len(sliders))
	sliders_sorted.sort_custom( func (a, b): return sliders[a].value >= sliders[b].value )
	for i in len(strategies):
		i = sliders_sorted[i]
		var n:int = floori(sliders[i].value / sum * total_n_students)
		remaining_students -= n
		#total_n_students = max(0, total_n_students-n)
		Gamemaster.students_by_strategy[strategies[i]] = n
		
		# a bit dirty; sets the text
		sliders[i].get_parent().text = texts[i] + " (" + str(n) + ")"
	# fuck it
	while remaining_students > 0:
		var farthest:int = 0
		for i in range(1, len(sliders)):
			if abs(
				sliders[i].value / sum - Gamemaster.students_by_strategy[strategies[i]] / float(total_n_students)
				) > abs(
					sliders[farthest].value / sum - Gamemaster.students_by_strategy[strategies[farthest]] / float(total_n_students)
				):
					farthest = i
		
		Gamemaster.students_by_strategy[strategies[farthest]] += 1
		remaining_students -= 1
		sliders[farthest].get_parent().text = texts[farthest] + " (" + str(Gamemaster.students_by_strategy[strategies[farthest]]) + ")"
	print(remaining_students)

func setup_sliders():
	for s in sliders:
		s.value = 0.000
	sliders[0].value = 1.0
