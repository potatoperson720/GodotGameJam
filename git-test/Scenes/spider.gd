extends Node2D

@export var speed = 25.0


#voeg nog toe |
@export var player : CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var PlayerCheck = $Area2D/PlayerCheck

func _process(delta: float) -> void:
	position.x += speed*delta*direction
	var player_in_range = false

	if PlayerLeft.is_colliding():
		if PlayerLeft.get_collider() is Player:
			set_direction(-1)
			player_in_range = true
	if PlayerRight.is_colliding():
		if PlayerRight.get_collider() is Player:
			set_direction(1)
			player_in_range = true
			
	if player_in_range and shoot_timer <=0:
		shoot_at_player()
		shoot_timer = shoot_cooldown


	

func set_direction(dir):
	direction = dir
	sprite.flip_h = direction < 0
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().reload_current_scene()


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
