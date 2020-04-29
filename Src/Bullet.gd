extends Area2D

var vel = Vector2()
onready var timer = get_node("TimerTiempoBala")
var direction = 1
var vel_x = 0
var vel_y = 0

func _ready():
	timer.set_wait_time(1)
	timer.start()
	pass  
	
func set_vel(x,y):
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
	$AnimatedSprite.play("Shot")		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_TimerTiempoBala_timeout():
	queue_free()
	
func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		$AnimatedSprite.play("Impact")
		body.dead()	
	queue_free()
