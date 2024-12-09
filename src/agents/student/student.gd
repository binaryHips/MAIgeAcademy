extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
var student_sprites:Array[SpriteFrames] = [preload("res://resources/images/eleve/studentAframes.tres"),preload("res://resources/images/eleve/studentBframes.tres")]
var prev_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.sprite_frames = student_sprites.pick_random()
	prev_position = position
	_animated_sprite.play("default")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(prev_position.x>position.x):
		_animated_sprite.scale.x = 2
	if(prev_position.x<position.x):
		_animated_sprite.scale.x = -2
	prev_position = position
	
	$ProgressBar.value = get_meta("brain").attention_span

func wait():
	_animated_sprite.play("default")

func walk():
	_animated_sprite.play("walk")
