extends KinematicBody2D

var vel = Vector2()
var direction_x = 1
var direction_y = 1
var is_dead = false
var speed_x
var speed_y

const FLOOR = Vector2(0,-1)
const MAX_VELX = 200
const MAX_VELY = 200
const DAMAGE_COLLISION = 10
const SHOT = preload("res://Scenes/Bullet.tscn")

func _ready():
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
	vel = Vector2(0,0)
	$CollisionShape2D.queue_free()
	#$AnimatedSprite.play("Dead")	
	
func multiple_shoot():
	#$AnimacionPlayer.play("multiple_shoot")
	var shot_array = []
	shot_array.append(SHOT.instance())
#	shot_array[0] = SHOT.instance()
	shot_array[0].set_vel(300,0)
#	shot_array[1] = SHOT.instance()
#	shot_array[1].set_vel(0,300)
#	shot_array[2] = SHOT.instance()
#	shot_array[2].set_vel(-300,0)
#	shot_array[3] = SHOT.instance()
#	shot_array[3].set_vel(0,-300)	
	get_parent().add_child(shot_array[0])
	shot_array[0].position = $Position2D.global_position
	


func _on_TimerMultipleShot_timeout():
	multiple_shoot()
