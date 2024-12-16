extends SpellResource
class_name FreezeSpellResource

func _init():
	spellRange = 200
	manaCost = 35
	spellDuration = 2
	spellScene = preload("res://src/scenes/spell/freezeSpell/freeze.tscn")
	name = "freeze"

func useSpell(target:Brain , caster:Brain):
	#var distance = caster.body.position.distance_to(target.body.position)
	#if(distance <= spellRange):
	caster.body.freeze(spellDuration)
	#caster.body.get_node("AnimatedSprite2D").play("freeze")
	caster.addMana(-1*manaCost)
	await caster.get_tree().create_timer(0.5 * Settings.speed_scale).timeout
	
	if is_instance_valid(target) && is_instance_valid(caster):
		spawnScene(target.body,caster.body)
	
		await target.get_tree().create_timer(0.5 * Settings.speed_scale).timeout
	
	return
	#target.override_state("frozen") 
	#else:
		#printerr("Logic error : Spell cast out of range")
