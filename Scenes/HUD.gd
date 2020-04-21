extends Node2D





func _on_Player_armor_change(armor):
	$ArmorBar.set_value(armor)


func _on_Player_hp_changed(new_amount):
	$HealthBar.set_value(new_amount)
