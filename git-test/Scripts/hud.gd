extends Control

@onready var hp_bar = $Panel
@onready var xp_bar = $Panel2



func process(float) -> void:
	hp_bar.scale.x(Gamemanager.hp/Gamemanager.max_hp)
	xp_bar.scale.x(Gamemanager.hp/Gamemanager.xp_next_level)
