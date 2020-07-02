extends Node

var nivel_act = 0
var skin = 0
var globulos_rojos = 0
var globulos_blancos = 0
var in_game = false

func _ready():
	_save()
	_load()
	
func _save():
	var date = {
		"nivel":nivel_act,
		"skin":skin,
		"in_game":in_game,
		"globulos_blancos":globulos_blancos,
		"globulos_rojos":globulos_rojos,		
	}
	Saves.save_game(date)
	
func _load():
	var date = {}
	date = Saves.load_game()
	nivel_act = int(date["nivel"])
	skin = int(date["skin"])
	in_game = bool(date["in_game"])
	setGlobulosBlancos(int(date["globulos_blancos"]))
	setGlobulosRojos(int(date["globulos_rojos"]))
	
	return date

func nextLevel():
	setNivel(getNivel()+1)

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

func setGlobulosRojos(cant):
	globulos_rojos = cant
	
func getGlobulosRojos():
	return  globulos_rojos
	
func getGlobulosBlancos():
	return  globulos_blancos

func setGlobulosBlancos(cant):
	globulos_blancos = cant
