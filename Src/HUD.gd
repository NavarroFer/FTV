extends Control

func _on_Player_armor_change(armor):
	$ArmorBar.set_value(armor)


func _on_Player_hp_changed(new_amount):
	$HealthBar.set_value(new_amount)
	
func _on_Player_item_picked(tipo,time):
	$TimerItem.setPicked(tipo,time)


func _on_Player_item_actived(tipo,time):
	$TimerItem.setActive(tipo,time)
