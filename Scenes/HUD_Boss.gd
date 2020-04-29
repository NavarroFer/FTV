extends Control

func _on_FinalBoss_hp_changed(new_amount):
	$HealthBar_Boss.set_value(new_amount)
