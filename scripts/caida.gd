extends Area2D

@export var gui : CanvasLayer

func _on_area_entered(body):
	if body is Player:
		print("¡Has muerto por caída!")
		body.queue_free()  # Elimina al jugador o llama a un método para manejar la muerte
		gui.game_over()
