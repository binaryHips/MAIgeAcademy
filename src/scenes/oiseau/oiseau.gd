extends AnimatedSprite2D

var coeffs = []
var sens = 1
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sens = [1, -1].pick_random()
	position.x = -500 * sens
	coeffs = []
	coeffs.append(randf_range(-100, 100)) # constant
	
	coeffs.append(randf_range(-1, 1)) # deg 1
	
	coeffs.append(randf_range(-0.001, 0.001)) # deg 2
	
	coeffs.append(randf_range(-0.00001, 0.00001)) # deg 3
	print(coeffs)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(global_position)
	#const h = 0.001
	const speed = 60;
	#var diff = abs(f(global_position.x+h)-f(global_position.x)/h)

	global_position.x += delta*speed * sens

	global_position.y = f(global_position.x)
	pass

func f(x: float) -> float:
	var res = 0
	for i in len(coeffs):
		res += coeffs[i]*(x ** i)
	return res

func _draw():
	if (false):
		for i in range(-500, 500):
			draw_line(
				Vector2(i, f(i)) - position,
				Vector2(i+1, f(i+1)) - position,
				Color.WEB_PURPLE,
				2.0)

func _input( event ):
	if event.is_action("ui_accept"):
		_ready()
