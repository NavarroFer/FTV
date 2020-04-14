extends Area2D

var Vacuna = preload("res://Sprites/PowerUps/vaccineChiquita.png")
var Barbijo = preload("res://Sprites/PowerUps/bombs_icon.png")
var Jabon = preload("res://Sprites/PowerUps/bombs_icon.png")
var Botas# = preload()

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
	$AnimationPlayer.play("Idle")

func _on_PowerUpVEL_body_entered(body):
	if "Player" in body.name:
		match Tipo:
			VACUNA:
				body.picked_power_up_shoot()
			BARBIJO:
				body.picked_power_up_armor()
			JABON:
				body.picked_power_up_invulneravility()
			BOTAS:
				body.picked_power_up_velocity()
		
		queue_free()
