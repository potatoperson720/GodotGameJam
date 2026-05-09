extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		if visible == true:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true

func _on_continue_pressed() -> void:
	visible = false
	get_tree().paused = false
