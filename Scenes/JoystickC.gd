extends Control

signal move_rigth
signal move_left
signal idle

func _on_Joystick_idle():
	emit_signal("idle")
	
func _on_Joystick_move_left():
	emit_signal("move_left")

func _on_Joystick_move_rigth():
	emit_signal("move_rigth")
