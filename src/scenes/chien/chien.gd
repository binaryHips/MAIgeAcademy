extends RigidBody2D

var speed := 200.0
var is_moving := false


@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.play("fixe")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_animated_sprite.play("court")
	var ax = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	apply_central_force(ax* speed)
	
func bark():
	_animated_sprite.play("aboie")
