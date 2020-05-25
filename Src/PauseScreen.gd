extends Control

func _ready():
	visible = false
	get_tree().paused = false
	
func _on_OGH_pause():
	get_tree().paused = true
	visible = true
