extends "res://Src/Enemy.gd"

func _ready():
	.setDamage(10)
	.setGravity(10)
	$AreaProximidad/AnimatedSprite.play("silueta")


#Por ahora el daño es fijo, pero se calculará en funcion de la distancia
func damageProximity(distancia):
	return 20	

func _on_AreaProximidad_body_entered(body):	
	if body.name == "Player":
		body.hp_decrease(damageProximity(0))


func _on_EnemyA_enemy_A_dead():
	$AreaProximidad/AnimatedSprite.stop()
	$AreaProximidad.queue_free()	
