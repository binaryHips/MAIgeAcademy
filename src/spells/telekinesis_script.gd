extends SpellResource

func _init():
	spellRange = 5
	manaCost = 10
	spellDuration = 0
	

func useSpell(target:Brain , caster:Brain):
	var distance = caster.body.position.distance_to(target.body.position)
	if(distance <= spellRange):
		caster.body.get_node("AnimatedSprite2D").play("telekinesis")
		caster.addMana(-1*manaCost)
		target.polymorph() 
	else:
		printerr("Logic error : Spell cast out of range")
