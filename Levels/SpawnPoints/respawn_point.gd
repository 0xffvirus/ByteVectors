extends Node2D

#@onready var death_sound = get_tree().root.get_node("/root/Node2D").get_node("Audio").get_node("Death_Sound")

func get_respawn_position():
	return position
	
func respawning():
	#death_sound.play()
	var player = get_tree().root.get_node("/root/Level_1").get_node("Player")
	var respawn_point = get_tree().root.get_node("/root/Level_1").get_node("SpawnPoints").get_node("Respawn point")
	player.position = respawn_point.position

func set_respawn_point(res_pos: Vector2):
	var respawn_point = get_tree().root.get_node("/root/Level_1").get_node("SpawnPoints").get_node("Respawn point")
	respawn_point.position = res_pos
	
