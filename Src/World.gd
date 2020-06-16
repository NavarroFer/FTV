extends Node

const PUNTOS_1 = 100
const PUNTOS_2 = 500
const PUNTOS_3 = 700

var points = 0
var cantEstrellas
export (int) var tipo = 1

signal level_completed(points)
signal tutorial_completed

func level_completed():	
	if(points <= PUNTOS_1):
		cantEstrellas = 1
	#2 Estrellas
	elif(points <= PUNTOS_2):
		cantEstrellas = 2
	#3 Estrellas
	else:
		cantEstrellas = 3
	#TUTORIAL	
	if(tipo == 0):
		print("Nivel tipo tutorial")
		emit_signal("tutorial_completed")
	#LEVEL COMUN
	elif(tipo == 1):
		print("Nivel tipo normal")
		emit_signal("level_completed",points)
	#FINAL BOSS
	elif(tipo == 2):
		print("Nivel tipo final")
		emit_signal("world_complete",points)
	Game.setGlobulosBlancos(Game.getGlobulosBlancos()+points)
	Game.nextLevel()
	Game._save()
	showMenuLevelComplete(cantEstrellas,points)
	
func showMenuLevelComplete(cantEstrellas,points):
	print("Hiciste "+ str(points) + " puntos!")
	print("Tu resultado fue de " + str(cantEstrellas) + " estrellas!")
	#$MenuLevelComplete.show(cantEstrellas,points)
	pass

func enemyKilled(name):
	match name:
		"EnemyA":
			setPoints(getPoints()+100)
		"EnemyB":
			setPoints(getPoints()+200)

func setPoints(new_amount):
	points = new_amount

func getPoints():
	return points

