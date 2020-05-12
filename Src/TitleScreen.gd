extends Node


func _ready():
	pass # Replace with function body.

func _on_Start_pressed():
	#BackgroundLoad.load_scene("res://Scenes/World.tscn")
	get_tree().change_scene("res://Scenes/World.tscn")
