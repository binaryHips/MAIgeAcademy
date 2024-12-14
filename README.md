# MAigeAcademy

![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)
![GDScript](https://img.shields.io/badge/GDScript-%2374267B.svg?style=for-the-badge&logo=godotengine&logoColor=white)

<img src="./resources/images/prof/transformgif.gif" alt="Mage" width="200">

---

Tom ZINCK, Killian VIGUIER, Andrew MANSOUR, Theo REYNIER

---

This project is an academic project created by a group of four.
It is a chase-like minigame where a teacher needs to stop her students from being distracted by candies.

---

## States and strategies.

### Teacher 

<img src="./resources/images/prof/mage1.png" alt="Mage" width="32">

The teacher has two main states:
* Idle: In this state, she teaches her favorite spells to her students.
* Cast: If a student is caught not paying attention and trying to sneak a candy, she casts one of her powerful spells!

She possess three main spells :
* Freeze: Freezes a student, preventing them from moving for a short period. <img src="./resources/images/eleve/StudentAgel.png" alt="AG" width="32"><img src="./resources/images/spell/freeze3.png" alt="F3" width="32"><img src="./resources/images/prof/glace3.png" alt="Mage" width="32">
* Transform: Transforms a student into an adorable sheep. Frightened, the sheep scurries back to its place. <img src="./resources/images/mouton/mouton_fixe.png" alt="AG" width="32"><img src="./resources/images/spell/transform-3.png" alt="S3" width="32"><img src="./resources/images/prof/transform3.png" alt="T3" width="32">
* Teleport: Channels her magical energy into her hands and instantly teleports a student back to their seat. <img src="./resources/images/eleve/studentBteleport-2.png" alt="TS3" width="32"><img src="./resources/images/prof/tele_spell3.png" alt="TS3" width="32">

### Student

<img src="./resources/images/eleve/studentA1.png" alt="SA" width="32"><img src="./resources/images/eleve/studentB1.png" alt="SB" width="32">

Students have three main states:
* Idle: The student attentively listens to the teacher.
* GoToCandy: The student devises strategies to sneak candies!
* GoBackToPlace: After being hit by a spell, the student reluctantly returns to their seat.

#### Strategies

Students use various strategies to maximize their candy intake:
* Standard Strategy: The student goes back and forth to collect every candy they spot.
* EscapeTheTeacher: The student avoids the teacher at all costs while grabbing candies along their path.
* LoneWolf: This student waits for others to make a move before sneaking out alone for a candy.
* TwoByTwo: This student has a partner, and they never separate, no matter what. Beware of the teacher’s wrath!
* CandyByTime: This student waits for the perfect moment to grab a candy and immediately returns to their seat.

