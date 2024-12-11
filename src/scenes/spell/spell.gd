extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D
var target_position:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#target_position = $"../student".global_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#orientation()
	pass
	
func orientation():
	var direction = target_position - global_position
	var angle = direction.angle()
	rotation = angle

func freeze():
	_animated_sprite.play("freeze")
	
func polymorph():
	_animated_sprite.play("transform")
