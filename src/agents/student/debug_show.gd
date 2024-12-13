extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var brain = get_parent().get_node("brain")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		$VBoxContainer/state.text = "state: " + brain.states[0]
		#$VBoxContainer/goal.text = "goal: " + brain.goals[0]["name"]
		$VBoxContainer/target_pos.text = "target: " + str(brain.move_target)
