extends Sprite

var pressed = preload("res://Sprites/VirtualJoystickPack/ButtonShootP.png")

func _on_Player_moved_shoot():
	texture = pressed
