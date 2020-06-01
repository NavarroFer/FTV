extends Node

var nivel_act = 0
var skin = 0
var in_game = false

func _ready():
	_save()
	_load()
	
func _save():
	var date = {
		"nivel":nivel_act,
		"skin":skin,
		"in_game":in_game
	}
	print("NIVEL ACTUAL "+str(nivel_act))
	Saves.save_game(date)
	
func _load():
	var date = {}
	date = Saves.load_game()
	nivel_act = int(date["nivel"])
	skin = int(date["skin"])
	in_game = bool(date["in_game"])
	return date
	
func setSkin(s):
	skin = s
	print(skin)
	_save()
	
func getNivel():
	return nivel_act

func setNivel(n):
	nivel_act = n

func hayPartidaIniciada():
	return in_game == true
	
func setInGame(boolean):
	in_game = boolean
