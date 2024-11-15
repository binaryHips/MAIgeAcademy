extends Control


var numSheep
var sheepDead
var sheepLeft

const SHEEP = preload("res://src/scenes/sheep/sheep.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numSheep = Settings.n_sheep
	print("---------------------------------------------\n")
	sheepDead = Gamemaster.world_state["out_of_bounds"].size()
	sheepLeft = numSheep - sheepDead
	print(Gamemaster.world_state["out_of_bounds"])
	print("Sheep : " + str(numSheep))
	print("dead :(  : " + str(sheepDead))
	print("alive :D : " + str(sheepLeft))
	$MarginContainer/VBoxContainer/RemainingSheepText.text = "Sheep Remaining : " + str(sheepLeft) + " / " + str(numSheep)
	
	for k in sheepLeft:
		var sheep := SHEEP.instantiate()
		sheep.scale = sheep.scale/1.5
		$Enclos.add_child(sheep)
		sheep.position = Vector2i(
			randi_range(-65, 65),
			randi_range(-65, 65)
		)

func celebrate() :
	#var tween = get_tree().create_tween()
	for sprite in $Enclos.get_children():
		var pos = sprite.position
		var jumpTo = pos + Vector2(0,-300)
		#tween.tween_property(sprite , "position" , jumpTo, 0.1)
		#tween.chain().tween_property(sprite, "position", pos, 0.1)
		sprite.position = jumpTo
		wait(0.5)
		sprite.position = pos


func wait(seconds:float) -> void:
	await get_tree().create_timer(seconds).timeout
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	celebrate()
	

func _on_button_pressed() -> void:
	print("heeeelp")
	get_tree().change_scene_to_file("res://src/scenes/menu/Menu.tscn")
