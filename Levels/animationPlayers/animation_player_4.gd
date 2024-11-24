extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed_scale = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("slowMo")):
		play("SlowMo_Effect")
	else:
		stop()
	

	


func _on_animation_finished(anim_name: StringName) -> void:
	pause()
