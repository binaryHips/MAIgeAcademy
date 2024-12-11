extends SpellResource
class_name PolymorphSpellResource

func _init():
	spellRange = 100
	manaCost = 30
	spellDuration = 6
	spellScene = preload("res://src/scenes/spell/transformSpell/transform.tscn")

func useSpell(target:Brain , caster:Brain):
	#var distance = caster.body.position.distance_to(target.body.positionban )
	#if(distance <= spellRange):
	
	caster.body.get_node("AnimatedSprite2D").play("polymorph")
	caster.addMana(-1*manaCost)
	caster.body.polymorph() # joue l'animation du sort de transformation
		#target.override_goal("polymorphed")
	#else:
		#printerr("Logic error : Spell cast out of range")
