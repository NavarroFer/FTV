extends "res://Src/Enemy.gd"

const SHOT = preload("res://Scenes/BulletBoss.tscn")
const DAMAGE_BULLET = 10

var timerCouldown

func _ready():
	.setGravity(0)
	.setDamage(25)
	initTimer()

func initTimer():
	timerCouldown = Timer.new()
	timerCouldown.set_one_shot(false)
	timerCouldown.autostart = true
	timerCouldown.connect("timeout",self,"_on_timerCouldown_timeout")
	timerCouldown.set_wait_time(2)
	add_child(timerCouldown)
	timerCouldown.start()
	
func _on_timerCouldown_timeout():
	if !is_dead:
		disparar()
	
func disparar():
	var shot = SHOT.instance()	
	get_parent().add_child(shot)
	if .getDirection() < 0 && $Position2D.position.x > 0:
		$Position2D.position.x *= -1
	if .getDirection() > 0 && $Position2D.position.x < 0:
		$Position2D.position.x *= -1
	shot.position = $Position2D.global_position
	shot.initAngle(direction*200,0)


