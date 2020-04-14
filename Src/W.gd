extends Sprite

var pressed = preload("res://Sprites/Keys/w pressed.png")

func _on_Player_moved_jump():
	texture = pressed
