extends CharacterBody2D
var mouseIn = 0
var drag
const recoil = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim =$AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("LeftClick"):
		anim.play("new_animation")
		velocity = (global_position-get_global_mouse_position()).normalized()*recoil
	$Sprite2D.rotation =get_angle_to(get_global_mouse_position())
	$Sprite2D.position = Vector2(12,12).rotated(get_angle_to(get_global_mouse_position())-PI/4)
	velocity -= velocity*delta*2
	move_and_slide()
