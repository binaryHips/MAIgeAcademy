extends SpellResource

func _init():
	spellRange = 100
	manaCost = 30
	spellDuration = 6
	

func useSpell(target:Brain , caster:Brain):
	var distance = caster.body.position.distance_to(target.body.position)
	if(distance <= spellRange):
		caster.body.get_node("AnimatedSprite2D").play("polymorph")
		caster.addMana(-1*manaCost)
		target.polymorph() 
	else:
		printerr("Logic error : Spell cast out of range")
