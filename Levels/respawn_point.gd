extends Node2D



func get_respawn_position():
	return position
	
func respawning():
	print("detath")
	var player = get_tree().root.get_node("/root/World").get_node("Player")
	var respawn_point = get_tree().root.get_node("/root/World").get_node("Respawn point")
	player.position = respawn_point.position


	
