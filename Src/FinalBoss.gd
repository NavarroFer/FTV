extends KinematicBody2D

var vel = Vector2()
var direction_x = 1
var direction_y = 1
var is_dead = false
var speed_x
var speed_y
export (int) var Health

signal hp_changed

const FLOOR = Vector2(0,-1)
const MAX_VELX = 200
const MAX_VELY = 200
const DAMAGE_COLLISION = 10
const SHOT = preload("res://Scenes/BulletBoss.tscn")
const DAMAGE_BULLET = 10

func _ready():
	$Explotion.emitting = false
	$Health.set_max(Health)
	$Health.set_current(Health)
	$AnimationPlayer.play("Idle")
	$TimerMultipleShot.start()
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	speed_x = MAX_VELX
	speed_y = MAX_VELY
	if !is_dead:
		vel.x = speed_x * direction_x
		vel.y = speed_y * direction_y
		#if direction == 1:
		#	$AnimatedSprite.flip_h = false
		#else:
		#	$AnimatedSprite.flip_h = true
		#$AnimatedSprite.play("Walk")
	vel = move_and_slide(vel,FLOOR)
	if is_on_wall():
		direction_x *= -1
	if is_on_ceiling():
		direction_y *= -1
	if is_on_floor():
		direction_y *= -1
	if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:							
					get_slide_collision(i).collider.hp_decrease(DAMAGE_COLLISION)
					


func dead():
	is_dead = true
	$AnimationPlayer.play("Death")
	$CollisionShape2D.queue_free()
	vel.x = 0
	vel.y = 20
	$TimerDeath.start()		
	$TimerAnimation.start()
	vel = move_and_slide(vel,FLOOR)	
	

func multiple_shoot():
	#$AnimacionPlayer.play("multiple_shoot")
	var shot0 = SHOT.instance()
	shot0.initAngle(300,0)	
	get_parent().add_child(shot0)
	shot0.position = $Position0.global_position

	var shot1 = SHOT.instance()
	shot1.initAngle(277.16,-114.805)
	get_parent().add_child(shot1)	
	shot1.position = $Position1.global_position

	var shot2 = SHOT.instance()
	shot2.initAngle(212.132,-213.132)
	get_parent().add_child(shot2)	
	shot2.position = $Position2.global_position

	var shot3 = SHOT.instance()
	shot3.initAngle(114.805,-277.16)
	get_parent().add_child(shot3)	
	shot3.position = $Position3.global_position
	
	var shot4 = SHOT.instance()
	shot4.initAngle(0,-300)	
	get_parent().add_child(shot4)
	shot4.position = $Position4.global_position

	var shot5 = SHOT.instance()
	shot5.initAngle(-114.805,-277.16)
	get_parent().add_child(shot5)	
	shot5.position = $Position5.global_position

	var shot6 = SHOT.instance()
	shot6.initAngle(-212.132,-213.132)
	get_parent().add_child(shot6)	
	shot6.position = $Position6.global_position

	var shot7 = SHOT.instance()
	shot7.initAngle(-277.16,-114.805)
	get_parent().add_child(shot7)	
	shot7.position = $Position7.global_position
#
	var shot8 = SHOT.instance()
	shot8.initAngle(-300,0)
	get_parent().add_child(shot8)
	shot8.position = $Position8.global_position

	var shot9 = SHOT.instance()
	shot9.initAngle(-277.16,114.805)
	get_parent().add_child(shot9)	
	shot9.position = $Position9.global_position
	
	var shot10 = SHOT.instance()
	shot10.initAngle(-212.132,213.132)
	get_parent().add_child(shot10)	
	shot10.position = $Position10.global_position
	
	var shot11 = SHOT.instance()
	shot11.initAngle(-114.805,277.16)
	get_parent().add_child(shot11)	
	shot11.position = $Position11.global_position

	var shot12 = SHOT.instance()
	shot12.initAngle(0,300)
	get_parent().add_child(shot12)	
	shot12.position = $Position12.global_position
	
	var shot13 = SHOT.instance()
	shot13.initAngle(114.805,277.16)
	get_parent().add_child(shot13)	
	shot13.position = $Position13.global_position
	
	var shot14 = SHOT.instance()
	shot14.initAngle(212.132,213.132)
	get_parent().add_child(shot14)	
	shot14.position = $Position14.global_position
	
	var shot15 = SHOT.instance()
	shot15.initAngle(277.16,114.805)
	get_parent().add_child(shot15)	
	shot15.position = $Position15.global_position
	


func _on_TimerMultipleShot_timeout():
	if !is_dead:
		multiple_shoot()
	
func decrease_health(amount):
	$Health.set_current($Health.get_current()-amount)
	if $Health.get_current() <= 0:
		dead()	

func _on_TimerDeath_timeout():
	is_dead = true
	queue_free()


func _on_Health_changed(new_amount):
	emit_signal("hp_changed",new_amount)


func _on_TimerAnimation_timeout():
	$Explotion.emitting = true
