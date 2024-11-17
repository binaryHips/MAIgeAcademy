extends RigidBody2D

var speed := 200.0
var is_moving := false
var prev_position = Vector2()


@onready var _animated_sprite = $AnimatedSprite2D
@onready var _audio_stream = $Ouaf


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
	
	var anim_speed = Settings.base_time_between_turns / Settings.time_between_turns
	_animated_sprite.speed_scale = anim_speed
	
	#var ax = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#apply_central_force(ax* speed)
	#pass
	
func wait():
	_animated_sprite.play("fixe")
	
func patrol():
	#print("Le chien court")
	_animated_sprite.play("court")
	randomStepSound().play()
	
func bark():
	#print("Le chien aboie !")
	_animated_sprite.play("aboie")
	_audio_stream.play()

func randomStepSound():
	var audio_step_1 = $Step1
	var audio_step_2 = $Step2
	var audio_step_3 = $Step3
	var audio_step_4 = $Step4
	var tab_audio = [audio_step_1, audio_step_2, audio_step_3, audio_step_4]
	var i = randi()%4
	return tab_audio[i]
