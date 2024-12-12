extends SpellResource
class_name PolymorphSpellResource

func _init():
	spellRange = 250
	manaCost = 30
	spellDuration = 2
	spellScene = preload("res://src/scenes/spell/transformSpell/transform.tscn")
	name = "transform"

func useSpell(target:Brain , caster:Brain):
	#var distance = caster.body.position.distance_to(target.body.positionban )
	#if(distance <= spellRange):
	
	caster.body.get_node("AnimatedSprite2D").play("polymorph")
	caster.addMana(-1*manaCost)
	#target.override_state("polymorphed")
	#else:
		#printerr("Logic error : Spell cast out of range")
