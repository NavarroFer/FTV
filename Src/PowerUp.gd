extends Area2D

var Vacuna = preload("res://Sprites/PowerUps/Vacuna.png")
var Barbijo = preload("res://Sprites/PowerUps/Barbijo.png")
var Jabon = preload("res://Sprites/PowerUps/Jabon.png")
var Botas = preload("res://Sprites/PowerUps/Bota.png")

export (int) var Tipo

const VACUNA = 1
const BARBIJO = 2
const JABON = 3
const BOTAS = 4

signal item_vacuna
signal item_barbijo
signal item_jabon
signal item_botas


func _ready():	
	match Tipo:
		VACUNA:
			$Sprite.texture = Vacuna
		BARBIJO:
			$Sprite.texture = Barbijo
		JABON:
			$Sprite.texture = Jabon
		BOTAS:
			$Sprite.texture = Botas
	$AnimationPlayer.play("Idle")

func _on_PowerUpVEL_body_entered(body):
	if "Player" in body.name:
		match Tipo:
			VACUNA:
				body.picked_power_up_invulneravility()
				emit_signal("item_vacuna")
			BARBIJO:
				body.picked_power_up_armor()
				emit_signal("item_barbijo")
			JABON:
				body.picked_power_up_damage()
				emit_signal("item_jabon")
			BOTAS:
				body.picked_power_up_velocity()
				emit_signal("item_botas")
		
		queue_free()
