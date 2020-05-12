extends Area2D

var Vacuna = preload("res://Sprites/PowerUps/Vacuna.png")
var Barbijo = preload("res://Sprites/PowerUps/Barbijo.png")
var Jabon = preload("res://Sprites/PowerUps/Jabon.png")
var Botas = preload("res://Sprites/PowerUps/Bota.png")
var time
var item_tutorial_agarrado = false

export (int) var Tipo
signal item_tutorial

const VACUNA = 1
const TIME_VACUNA = 5
const BARBIJO = 2
const TIME_BARBIJO = 5
const JABON = 3
const TIME_JABON = 10
const BOTAS = 4
const TIME_BOTAS = 10

func _ready():	
	match Tipo:
		VACUNA:
			$Sprite.texture = Vacuna
			time = TIME_VACUNA
		BARBIJO:
			$Sprite.texture = Barbijo
			time = TIME_BARBIJO
		JABON:
			$Sprite.texture = Jabon
			time = TIME_JABON
		BOTAS:
			$Sprite.texture = Botas
			time = TIME_BOTAS
	$AnimationPlayer.play("Idle")

func _on_PowerUp_body_entered(body):	
	if item_tutorial_agarrado == false && get_parent().name == "World":
		emit_signal("item_tutorial")
	if "Player" in body.name:
		body.picked_power_up(Tipo,time)
		queue_free()


