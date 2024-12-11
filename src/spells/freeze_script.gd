extends SpellResource
class_name FreezeSpellResource

func _init():
	spellRange = 80
	manaCost = 35
	spellDuration = 4
	spellScene = preload("res://src/scenes/spell/freezeSpell/freeze.tscn")

func useSpell(target:Brain , caster:Brain):
	#var distance = caster.body.position.distance_to(target.body.position)
	#if(distance <= spellRange):
	
	caster.body.get_node("AnimatedSprite2D").play("freeze")
	caster.addMana(-1*manaCost)
	#target.override_state("frozen") 
	#else:
		#printerr("Logic error : Spell cast out of range")
