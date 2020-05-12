extends Sprite

var pressed = preload("res://Sprites/VirtualJoystickPack/ButtonActionP.png")

func _on_Player_item_actived(tipo,time):
	texture = pressed
