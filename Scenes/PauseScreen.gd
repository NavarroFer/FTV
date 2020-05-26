extends Control

func _ready():
	visible = false
	get_tree().paused = false
	
func _on_OGH_pause():
	get_tree().paused = true
	visible = true

func _on_Continue_pressed():
	get_tree().paused = false
	visible = false


func _on_PlayAgain_pressed():
	get_tree().reload_current_scene()
