extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
var student_sprites:Array[SpriteFrames] = [preload("res://resources/images/eleve/studentAframes.tres"),preload("res://resources/images/eleve/studentBframes.tres")]
var prev_position = Vector2()


var custom_debug_msg:String = ""
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
	if $AnimatedSprite2D.animation == "polymorph"\
		or $AnimatedSprite2D.animation == "teleport"\
		or $AnimatedSprite2D.animation == "freeze": return
	_animated_sprite.play("default")

func walk():
	if $AnimatedSprite2D.animation == "polymorph"\
		or $AnimatedSprite2D.animation == "teleport"\
		or $AnimatedSprite2D.animation == "freeze": return
	_animated_sprite.play("walk")
	
func freeze():
	_animated_sprite.play("freeze")

func unfreeze():
	_animated_sprite.play("walk")
	
func teleport():
	_animated_sprite.play("teleport")

func polymorph():
	_animated_sprite.play("polymorph")


func _on_animated_sprite_2d_animation_finished() -> void:
	walk()
