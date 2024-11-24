extends Node2D

@onready var background_music = $Audio/Background_musc

func _ready() -> void:
	background_music.play()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("slowMo"):
		$Slow_Overlay.visible = true
		
	else:
		$Slow_Overlay.visible = false
