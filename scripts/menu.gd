extends Control


func _ready() -> void:
	$Buttons/Start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Escenas/Level.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
