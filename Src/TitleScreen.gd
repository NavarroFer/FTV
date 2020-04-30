extends Node


func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer2/Start.grab_focus()
	pass # Replace with function body.

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer2/Start.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer2/Start.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer2/Exit.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer2/Exit.grab_focus()
	
	pass

func _on_Start_pressed():
	#BackgroundLoad.load_scene("res://Scenes/World.tscn")
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Exit_pressed():
	get_tree().quit()
