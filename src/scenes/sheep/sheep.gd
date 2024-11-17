extends RigidBody2D

var prev_position = Vector2()
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_position = position
	_animated_sprite.play("fixe", randf_range(0, 1.0))
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
	randomStepSound().play()
	randomBelement()
	
func jump():
	print("Le mouton saute")
	_animated_sprite.play("saute")

func randomStepSound():
	var audio_step_1 = $Step1
	var audio_step_2 = $Step2
	var audio_step_3 = $Step3
	var audio_step_4 = $Step4
	var tab_audio = [audio_step_1, audio_step_2, audio_step_3, audio_step_4]
	var i = randi()%4
	return tab_audio[i]
	
func randomBelement():
	var bele = $Belement
	var i = randi()%10
	var pitch = randf_range(0.90, 1.15)
	if i == 0:
		bele.pitch_scale = pitch
		bele.play()
