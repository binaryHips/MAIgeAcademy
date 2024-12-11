extends Resource

class_name SpellResource

var spellRange = 50
var manaCost = 5
var spellDuration = 0
var spellScene : PackedScene

func getRange():
	return range
func setRange(range):
	spellRange = range

func getCost():
	return getCost
func setCost(cost):
	manaCost = cost
	
func getDuration():
	return spellDuration
func setDuration(duration):
	spellDuration = duration
	
func getScene():
	return spellScene.instantiate()
func setScene(scene):
	spellScene = scene

func useSpell(target:Brain , caster:Brain):
	pass

func spawnScene(target:Node2D,caster:Node2D):
	var scene = spellScene.instantiate()
	scene.target_position = target.position
	target.get_tree().get_root().add_child(scene)
	scene.global_position = caster.global_position
