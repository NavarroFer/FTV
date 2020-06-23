extends Node

var niveles = ["res://Scenes/World.tscn"
,"res://Scenes/World2.tscn"
,"res://Scenes/World3.tscn"
,"res://Scenes/WorldFinal.tscn"]

#var data = {
#	"skin":"0",
#	"nivel":"-1"
#}

func _ready():
	if(!Game.hayPartidaIniciada()):
		$Continue.disabled = true
	else:
		$Continue.disabled = false

func _on_Start_pressed():	
	var date = {}
	date = Saves.load_game()
	get_tree().change_scene("res://Scenes/SkinSelector.tscn")
	Game.setInGame(true)
	Game.setNivel(0)
#	else:
#		get_tree().change_scene(niveles[int(date["nivel"])])


func _on_SelectSkin_pressed():
	get_tree().change_scene("res://Scenes/SkinSelector.tscn")


func _on_Continue_pressed():
	var date = {}
	date = Game._load()
	get_tree().change_scene(niveles[int(date["nivel"])])


func _on_Market_pressed():
	get_tree().change_scene("res://Scenes/Market.tscn")
