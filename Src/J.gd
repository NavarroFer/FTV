extends Sprite

var pressed = preload("res://Sprites/Keys/j pressed.png")

func _on_Player_moved_shoot():
	texture = pressed
