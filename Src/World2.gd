extends Node

const PUNTOS_1 = 1000
const PUNTOS_2 = 2000
const PUNTOS_3 = 3000

var points = 0
var cantEstrellas

func level_completed():
	#1 Estrella
	if(points <= PUNTOS_1):
		cantEstrellas = 1
	#2 Estrellas
	elif(points <= PUNTOS_2):
		cantEstrellas = 2
	#3 Estrellas
	else:
		cantEstrellas = 3
	showMenuLevelComplete(cantEstrellas)
	
func showMenuLevelComplete(cantEstrellas):
	#$MenuLevelComplete.show(cantEstrellas,points)
	pass

func enemyKilled(tipo):
	match tipo:
		"EnemyA": setPoints(getPoints()+100)
		"EnemyB": setPoints(getPoints()+200)

func setPoints(new_amount):
	points = new_amount

func getPoints():
	return points
