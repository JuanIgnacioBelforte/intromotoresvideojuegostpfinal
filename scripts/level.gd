extends Node2D

@onready var musica : AudioStreamPlayer = $Audio

func _ready():
	get_tree().paused = false
	musica.play()
	GLOBAL.score = 0

func _on_area_entered(body):
	if body == Player:
		print("¡El jugador cayó!")
		get_tree().change_scene_to_file("res://Escenas/GUI.tscn")
