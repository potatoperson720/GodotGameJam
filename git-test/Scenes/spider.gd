extends Node2D

@export var speed = 25.0
@export var player : CharacterBody2D
@export var bullet_scene : PackedScene
@export var shoot_cooldown = 2.0

@onready var sprite = $AnimatedSprite2D
@onready var PlayerCheck = $Area2D2/PlayerCheck  # detectie cirkel

var direction = 1
var shoot_timer = 0.0
var player_detected = false

func _process(delta: float) -> void:
	shoot_timer -= delta

	if player_detected and player != null:
		# Loop naar de speler toe
		var dir = sign(player.global_position.x - global_position.x)
		set_direction(dir)
		position.x += speed * delta * direction

		# Schiet als timer klaar is
		if shoot_timer <= 0:
			shoot_at_player()
			shoot_timer = shoot_cooldown
	else:
		# Gewoon blijven staan als speler niet in range is
		pass

func set_direction(dir):
	direction = dir
	sprite.flip_h = direction < 0

func shoot_at_player():
	if bullet_scene and player:
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		var dir_vec = (player.global_position - global_position).normalized()
		bullet.direction = dir_vec  # pas aan op jouw bullet script

# Area2D2 = detectie cirkel (groot) → enemy loopt naar speler
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body == player:
		player_detected = true

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body == player:
		player_detected = false

# Area2D = kill cirkel (klein) → speler sterft
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().reload_current_scene()
