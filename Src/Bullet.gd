extends Area2D

var vel = Vector2()
onready var timer = get_node("TimerTiempoBala")
var direction = 1
var vel_x = 0
var vel_y = 0
var tirador = null
var damage_Bullet

func _ready():
	timer.set_wait_time(1)
	timer.start()
	
func init(tipo,damage,x,y):
	tirador = tipo
	if x != 0 && y != 0:
		if sign(x) == -1:
			$AnimatedSprite.rotate(PI)
		$AnimatedSprite.rotate(atan(y/x))
	elif sign(x) == -1:
		$AnimatedSprite.rotate(PI)
	elif sign(y) == -1:
		$AnimatedSprite.rotate(-PI/2)
	elif sign(y) == 1:
		$AnimatedSprite.rotate(PI/2)
	
	if tirador == 1:
		$AnimatedSprite.play("Shot")
		$CollisionShape2D.visible = true	
		$CollisionShape2D2.visible = false	
	elif tirador == 2:
		$AnimatedSprite.play("ShotBoss")
		$CollisionShape2D.visible = false	
		$CollisionShape2D2.visible = true	
	damage_Bullet = damage
	vel_x = x
	vel_y = y

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _physics_process(delta):
	vel.x = vel_x * delta
	vel.y = vel_y * delta
	translate(vel)		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_TimerTiempoBala_timeout():
	queue_free()
	
func _on_Bullet_body_entered(body):
	#Disparo el player a un enemigo normal
	if "Enemy" in body.name && tirador == 1:
		$AnimatedSprite.play("Impact")
		body.dead()	
		$TimerImpact.start()
	elif "FinalBoss" in body.name && tirador == 1:
		$AnimatedSprite.play("Impact")
		body.decrease_health(damage_Bullet)	
		$TimerImpact.start()
	elif "Player" in body.name && tirador == 2:
		#$AnimatedSprite.play("ImpactBoss")
		body.hp_decrease(damage_Bullet)	
		queue_free()
	$AnimatedSprite.play("Impact")
	$TimerImpact.start()


func _on_TimerImpact_timeout():
	queue_free()
