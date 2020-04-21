extends ProgressBar

func _on_Player_hp_changed(new_amount):
	set_value(new_amount)
	print("Cambio vida:" + str(new_amount))

