extends Control

var master_bus = AudioServer.get_bus_index("Master")
@onready var Exit_button = $MarginContainer/VBoxContainer/Exit_Button as Button

signal exit_options_menu

func _ready():
	Exit_button.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/menu.tscn")

func _on_display_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_brightness_slider_value_changed(value):
	GlobalWorldEnvironment.environment.adjustment_brightness = value


func _on_master_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus,value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
		
