extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D
var target_position:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	orientation()
	global_position = global_position.move_toward(target_position,delta*2)
	pass
	
func orientation():
	var direction = target_position - global_position
	var angle = direction.angle() - PI/2
	rotation = angle

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("student"):
		body.get_meta("brain").override_state("frozen") 
	pass # Replace with function body.
