extends Control

signal next_level

func _ready():
	get_tree().paused = false
	visible = false

func _on_World2_level_completeds(points):
	$MarginContainer/VBoxContainer/HBoxContainer/Points.text = "Points: " + str(points)
	get_tree().paused = true
	visible = true


func _on_Continue_pressed():
	get_tree().paused = false
	visible = false
	emit_signal("next_level")


func _on_World_tutorial_completed():
	emit_signal("next_level")
