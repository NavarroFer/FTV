extends Area2D

var vel = Vector2()
#onready var timer = get_node("TimerTiempoBala")
var types = [preload("res://Sprites/Player/Objects/balas0.png"),
preload("res://Sprites/Player/Objects/balas1.png"),
preload("res://Sprites/Player/Objects/balas2.png"),
preload("res://Sprites/Player/Objects/balas3.png"),
preload("res://Sprites/Player/Objects/balas4.png"),]
var timerBala
var timerImpact
var visibilityNotifier
var direction = 1
var vel_x = 0
var vel_y = 0
var tirador = null
var damage_Bullet

func _ready():
	initTimers()	
	initTipo()
	connect("body_entered",self,"_on_body_entered")
	visibilityNotifier = VisibilityNotifier2D.new()
	visibilityNotifier.connect("screen_exited",self,"_on_VisibilityNotifier2D_screen_exited")
	set_scale_VN(0.25,0.2)
	
	
func set_scale_VN(x, y):
	visibilityNotifier.scale.x = x
	visibilityNotifier.scale.y = y
	
func initTimers():	
	timerBala = Timer.new()
	timerBala.set_one_shot(true)
	timerBala.connect("timeout",self,"_on_TimerTiempoBala_timeout")
	timerBala.set_wait_time(1)
	add_child(timerBala)
	timerBala.start()
	
	timerImpact = Timer.new()
	timerImpact.set_one_shot(true)
	timerImpact.connect("timeout",self,"_on_TimerImpact_timeout")
	timerImpact.set_wait_time(1)
	add_child(timerImpact)
	timerImpact.start()
	
func initTipo():
	$AnimationPlayer.play("Shot")
	damage_Bullet = 30

func initAngle(x,y):
#func init(tipo,damage,x,y):
#	tirador = tipo
	if x != 0 && y != 0:
		if sign(x) == -1:
			$Sprite.rotate(PI)
		$Sprite.rotate(atan(y/x))
	elif sign(x) == -1:
		$Sprite.rotate(PI)
	elif sign(y) == -1:
		$Sprite.rotate(-PI/2)
	elif sign(y) == 1:
		$Sprite.rotate(PI/2)

	vel_x = x
	vel_y = y

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func _physics_process(delta):
	vel.x = vel_x * delta
	vel.y = vel_y * delta
	translate(vel)		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_TimerTiempoBala_timeout():
	queue_free()
	
func set_type(t):
	$Sprite.texture = types[t]
		

func _on_body_entered(body):
	#Disparo el player a un enemigo normal
	if "Enemy" in body.name: #&& tirador == 1:
		#$AnimatedSprite.play("Impact")
		body.dead()	
		timerImpact.start()
	elif "FinalBoss" in body.name:# && tirador == 1:
		#$AnimatedSprite.play("Impact")
		body.decrease_health(damage_Bullet)	
		timerImpact.start()
	elif "Player" in body.name:# && tirador == 2:
		#$AnimatedSprite.play("ImpactBoss")
		body.hp_decrease(damage_Bullet)			
		queue_free()
	timerImpact.start()


func _on_TimerImpact_timeout():
	queue_free()
