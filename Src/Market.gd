extends Control

func _ready():
	$ScrollContainer/VBoxContainer.add_constant_override("separation", 30)
	$ScrollContainer/VBoxContainer/Armas.add_constant_override("separation", 60)
	$ScrollContainer/VBoxContainer/Habilidades.add_constant_override("separation", 60)
	$ScrollContainer/VBoxContainer/Others.add_constant_override("separation",60)
	
	
	


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
