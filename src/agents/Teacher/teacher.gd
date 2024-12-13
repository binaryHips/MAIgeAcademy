extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D
var prev_position = Vector2()
var is_frozen:bool = false
var is_transformed:bool = false
var is_tele:bool = false
@onready var freeze_timer:Timer = $freeze_timer
@onready var transform_timer:Timer = $transform_timer
@onready var tele_timer:Timer = $tele_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_position = position
	_animated_sprite.play("default")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_frozen:
		return
	if is_transformed:
		return
	if is_tele:
		return
	if(prev_position.x>position.x):
		_animated_sprite.scale.x = 2
	if(prev_position.x<position.x):
		_animated_sprite.scale.x = -2
	prev_position = position
	

func wait():
	_animated_sprite.play("default")

func walk():
	_animated_sprite.play("walk")
	
func freeze(temps):
	is_frozen = true
	_animated_sprite.play("freeze")
	freeze_timer.start(temps)
	Stats.spells_used["Freeze"] += 1
	
func polymorph(temps):
	is_transformed = true
	_animated_sprite.play("polymorph")
	transform_timer.start(temps)
	Stats.spells_used["Polymorph"] += 1


func telekinesis(temps):
	is_tele = true
	_animated_sprite.play("telekinesis")
	tele_timer.start(temps)
	Stats.spells_used["Telekinesis"] += 1


func _on_freeze_timer_timeout() -> void:
	is_frozen = false

func _on_transform_timer_timeout() -> void:
	is_transformed = false

func _on_tele_timer_timeout() -> void:
	is_tele = false
