extends Popup

# Video Settings
@onready var display_options = $SettingsTabs/Video/MarginContainer/Videosettings/DisplayButton
@onready var vsync_btn = $SettingsTabs/Video/MarginContainer/Videosettings/VsyncButton
@onready var display_fps_btn = $SettingsTabs/Video/MarginContainer/Videosettings/DisplayFpsButton
@onready var max_fps_slider = $SettingsTabs/Video/MarginContainer/Videosettings/MaxFPS
@onready var brightness_slider = $SettingsTabs/Video/MarginContainer/Videosettings/BrightnessSlider

# Audio Settings
@onready var master_slider = $SettingsTabs/Audio/MarginContainer/Audiosettings/MasterVolSlider
@onready var music_slider = $SettingsTabs/Audio/MarginContainer/Audiosettings/MusicVolSlider
@onready var sfx_slider = $SettingsTabs/Audio/MarginContainer/Audiosettings/SFXVolSlider

# Gameplay Settings
@onready var fov_slider = $SettingsTabs/Gameplay/MarginContainer/Gamesettings/FOVBox/FOVSlider
@onready var mouse_slider = $SettingsTabs/Gameplay/MarginContainer/Gamesettings/MouseBox/MouseSlider2

func _ready() -> void:
	pass
	

# FULLSCREEN toggle
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	pass
# V-SYNC toggle
func _on_vsync_button_toggled(toggled_on: bool) -> void:
	pass

# Show FPS toggle
func _on_display_fps_toggled(toggled_on: bool) -> void:
	pass
# FPS slider
func _on_fps_slider_value_changed(value: float) -> void:
	pass
# Brightness slider (example placeholder logic)
func _on_brightness_slider_value_changed(value: float) -> void:
	pass

# FOV slider
func _on_fov_slider_value_changed(value: float) -> void:
	pass

# Master volume slider
func _on_master_vol_slider_value_changed(value: float) -> void:
	pass

# Music volume slider
func _on_music_vol_slider_value_changed(value: float) -> void:
	pass
# SFX volume slider
func _on_sfx_vol_slider_value_changed(value: float) -> void:
	pass
# Mouse sensitivity slider
