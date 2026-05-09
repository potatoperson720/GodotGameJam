extends CharacterBody2D
var mouseIn = 0
var drag
const recoil = 300.0
const JUMP_VELOCITY = -400.0
var bulletSpeed = 200.0
var bulletAmount = 5
var cooldown = 0
@onready var anim =$AnimatedSprite2D
@export var bulletScene: PackedScene

func _physics_process(delta: float) -> void:
	var viewport = get_viewport_rect().size
	if Input.is_action_pressed("LeftClick"):
		if not cooldown:
			anim.play("new_animation")
			velocity = (global_position-get_global_mouse_position()).normalized()*recoil
		
			for i in range(bulletAmount):
				var Bullet = bulletScene.instantiate()
				var offset = randf_range(-PI/6,PI/6)
				Bullet.global_position = $Sprite2D/Marker2D.global_position
				Bullet.linear_velocity = Vector2(1,1).rotated(get_angle_to(get_global_mouse_position())-PI/4+offset)*bulletSpeed
				get_tree().current_scene.add_child(Bullet)
			$Timer.start()
			cooldown = 1
	if global_position.x < 0:
		global_position.x = 0
		velocity.x= 50
	elif global_position.x>viewport.x:
		global_position.x = viewport.x
		velocity.x= -50
	if global_position.y < 0:
		global_position.y = 0
		velocity.y= 50
	elif global_position.y>viewport.y:
		global_position.y = viewport.y
		velocity.y= -50
		
	$Sprite2D.rotation =get_angle_to(get_global_mouse_position())
	$Sprite2D.position = Vector2(12,12).rotated(get_angle_to(get_global_mouse_position())-PI/4)
	
	velocity -= velocity*delta*2
	move_and_slide()


func _on_timer_timeout() -> void:
	cooldown = 0
