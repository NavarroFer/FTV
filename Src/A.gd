extends Sprite

var pressed = preload("res://Sprites/Keys/JoystickLOK.png")

func _on_Player_moved_left():
		texture = pressed
