class_name Mainmenu
extends Control
@onready var Play = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var Option = $MarginContainer/HBoxContainer/VBoxContainer/Option as Button
@onready var Quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var start_level = preload("res://Levels/lv1.tscn") as PackedScene


func _ready():
	
	handeling_signals()
func _on_play_pressed() -> void:	
	get_tree().change_scene_to_packed(start_level)
	



func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/options.tscn")
	

func _on_quit_pressed() -> void:
	get_tree().quit()


func handeling_signals():
	Play.button_down.connect(_on_play_pressed)
	Option.button_down.connect(_on_option_pressed)
	Quit.button_down.connect(_on_quit_pressed)
