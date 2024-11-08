extends RigidBody2D

var speed := 200.0
var is_moving := false
var prev_position = Vector2()


@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_position = position
	_animated_sprite.play("fixe")
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if linear_velocity.x < 0:
		#_animated_sprite.scale.x = -2
	#if linear_velocity.x > 0:
		#_animated_sprite.scale.x = 2
	if(prev_position.x>position.x):
		_animated_sprite.scale.x = -2
	if(prev_position.x<position.x):
		_animated_sprite.scale.x = 2
	#_animated_sprite.play("court")
	prev_position = position
	#var ax = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#apply_central_force(ax* speed)
	#pass
	
func wait():
	_animated_sprite.play("fixe")
	
func patrol():
	#print("Le chien court")
	_animated_sprite.play("court")
	
func bark():
	print("Le chien aboie !")
	_animated_sprite.play("aboie")
