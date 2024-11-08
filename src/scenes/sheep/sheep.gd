extends RigidBody2D

var prev_position = Vector2()
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_position = position
	_animated_sprite.play("fixe")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(prev_position.x<position.x):
		_animated_sprite.scale.x = -2
	if(prev_position.x>position.x):
		_animated_sprite.scale.x = 2
		
	prev_position = position
	#pass

func wait():
	_animated_sprite.play("fixe")
	
func walk():
	#print("Le mouton marche")
	_animated_sprite.play("marche")
	
func jump():
	#print("Le mouton saute")
	_animated_sprite.play("saute")
