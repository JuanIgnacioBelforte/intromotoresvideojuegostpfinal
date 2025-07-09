extends Node2D

@onready var musica : AudioStreamPlayer = $Audio

func _ready():
	get_tree().paused = false
	musica.play()
	GLOBAL.score = 0
