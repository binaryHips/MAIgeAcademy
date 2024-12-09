extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func freeze():
	_animated_sprite.play("freeze")
	
func polymorph():
	_animated_sprite.play("transform")
