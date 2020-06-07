extends "res://Src/Bullet.gd"

func _ready():
	.set_scale_VN(0.55,0.5)
	
func initTipo():
	$AnimationPlayer.play("ShotBoss")
	damage_Bullet = 10
