extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D
var target:RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	orientation()
	global_position = global_position.move_toward(target.global_position,delta*150)
	pass
	
func orientation():
	var direction = target.global_position - global_position
	var angle = direction.angle() - PI
	rotation = angle
	$shadow.global_rotation = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("student"):
		body.get_meta("brain").override_state("frozen") 
		self.queue_free()
	pass # Replace with function body.
