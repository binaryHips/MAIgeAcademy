extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D
var prev_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_position = position
	_animated_sprite.play("default")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(prev_position.x>position.x):
		_animated_sprite.scale.x = -2
	if(prev_position.x<position.x):
		_animated_sprite.scale.x = 2
	prev_position = position

func wait():
	_animated_sprite.play("default")

func walk():
	_animated_sprite.play("walk")
	
func freeze():
	_animated_sprite.play("freeze")
	
func polymorph():
	_animated_sprite.play("polymorph")

func telekinesis():
	_animated_sprite.play("telekinesis")
