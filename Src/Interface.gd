extends Control

signal health_changed(health)

func _on_Player_hp_change(health):
	emit_signal("health_changed",health)	
