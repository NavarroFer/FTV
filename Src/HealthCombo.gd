extends Node

func _on_Player_hp_change(health):
	$Health.set_current(health)
