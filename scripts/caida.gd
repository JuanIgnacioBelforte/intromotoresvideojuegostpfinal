extends Area2D

func _on_area_entered(body):
	if body == Player:
		print("¡El jugador cayó!")
		get_tree().change_scene_to_file("res://Escenas/GUI.tscn")
