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

func _ready():
	$AnimationPlayer.play("Idle")
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
