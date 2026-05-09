extends RigidBody2D
class_name bullet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_animated_sprite_2d_animation_finished() -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()
