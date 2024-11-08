extends AnimatedSprite2D

var coeffs = []
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = -500
	for i in randi_range(1, 3):
		coeffs.append(randf_range(-1, 1))
	print(coeffs)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(position)
	const h = 0.001
	var diff = abs(f(position.x)-f(position.x+h))/h
	if(diff != 0):
		position.x += delta*diff*1000
	else:
		position.x += delta*10
	position.y = f(position.x)
	print(diff)
	pass

func f(x: float) -> float:
	var res = 0.
	for i in len(coeffs):
		res += coeffs[i]*(x ** i)
	return res
