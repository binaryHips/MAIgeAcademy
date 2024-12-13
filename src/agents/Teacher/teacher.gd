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
		_animated_sprite.scale.x = 2
	if(prev_position.x<position.x):
		_animated_sprite.scale.x = -2
	prev_position = position
	

func wait():
	# on cut pas les animations
	if $AnimatedSprite2D.animation == "polymorph" or $AnimatedSprite2D.animation == "telekinesis": return

	_animated_sprite.play("default")

func walk():
	
	if $AnimatedSprite2D.animation == "polymorph" or $AnimatedSprite2D.animation == "telekinesis": return
	
	_animated_sprite.play("walk")
	
func freeze(temps):
	_animated_sprite.play("freeze")
	freeze_timer.start(temps)
	Stats.spells_used["Freeze"] += 1
	
func polymorph(temps):
	_animated_sprite.play("polymorph")
	Stats.spells_used["Polymorph"] += 1


func telekinesis(temps):
	_animated_sprite.play("telekinesis")

	Stats.spells_used["Telekinesis"] += 1


func _on_animated_sprite_2d_animation_finished() -> void:
	walk()
