extends Node

var xp = 0
var xp_next_level = 100
var level = 1
var hp = 100
var max_hp = 100
var damage = 1
var startijd = 0

#started van de speeltijd
func _ready() -> void:
	startijd = Time.get_ticks_msec()
	
#add xp dat level up aanroept
func add_xp(amount: int = 10) -> void:
	xp += amount
	while xp >= xp_next_level:
		xp -= xp_next_level
		level_up()
		
#level up functie
func level_up() -> void:
	level += 1
	xp_next_level = int(xp_next_level * 1.5)  # elke level moeilijker
	max_hp += 20
	hp = max_hp  # herstel HP bij level-up
	print("Level up! Nu level ", level)
	
#hit, damage moet nog worden verhoogd
func hit(schade: int = damage) -> void:
	hp = max(0, hp - schade)
	if hp == 0:
		game_over()

func game_over() -> void:
	print("Game over!")
