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
			BARBIJO:
				body.picked_power_up_armor()
			JABON:
				body.picked_power_up_damage()
			BOTAS:
				body.picked_power_up_velocity()
		
		queue_free()
