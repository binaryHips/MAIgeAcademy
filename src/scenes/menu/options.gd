extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_sliders()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var sliders:Array[HSlider] = [$Naive/slider_naive, $Escape/slider_escape, $LoneWolf/slider_wolf, $CandyByTime/slider_candy_time, $Friend/slider_friend]

func update_sliders(just_modified:int):
	
	var sum:float
	for s in sliders:
		sum += s.value
	
	var sum_others := sum - sliders[just_modified].value
	var delta := (sum-1.0)
	
	for i in range(len(sliders)):
		if i != just_modified:
			sliders[i].value -= delta * sliders[i].value / sum_others;

func setup_sliders():
	for s in sliders:
		s.value = 1.0/len(sliders)


func _on_slider_naive_value_changed(value: float) -> void:
	update_sliders(0)


func _on_slider_escape_value_changed(value: float) -> void:
	update_sliders(1)


func _on_slider_wolf_value_changed(value: float) -> void:
	update_sliders(2)


func _on_slider_candy_time_value_changed(value: float) -> void:
	update_sliders(3)


func _on_slider_friend_value_changed(value: float) -> void:
	update_sliders(4)
