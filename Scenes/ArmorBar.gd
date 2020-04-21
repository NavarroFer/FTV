extends ProgressBar


func _on_Player_armor_change(armor):
	set_value(armor)
	print("Cambio armor:" + str(armor))
