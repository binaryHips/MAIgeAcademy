extends SpellResource
class_name TelekinesisSpellResource

func _init():
	spellRange = 5
	manaCost = 10
	spellDuration = 0
	

func useSpell(target:Brain , caster:Brain):
	var distance = caster.body.position.distance_to(target.body.position)
	if(distance <= spellRange):
		caster.body.get_node("AnimatedSprite2D").play("telekinesis")
		caster.addMana(-1*manaCost)
		target.override_state("teleporting") 
	else:
		printerr("Logic error : Spell cast out of range")
