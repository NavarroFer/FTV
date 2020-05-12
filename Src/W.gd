extends Sprite

var pressed = preload("res://Sprites/VirtualJoystickPack/ButtonJumpP.png")

func _on_Player_moved_jump():
	texture = pressed
