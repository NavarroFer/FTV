extends Sprite
signal move_left
signal move_rigth
signal idle


func _on_Joystick_Button_move_left():
	emit_signal("move_left")


func _on_Joystick_Button_move_rigth():
	emit_signal("move_rigth")


func _on_Joystick_Button_idle():
	emit_signal("idle")
