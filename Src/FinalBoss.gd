extends KinematicBody2D

var vel = Vector2()
var direction = 1
var is_dead = false
var speed

const FLOOR = Vector2(0,-1)
const MAX_VELX = 200
const MAX_VELY = 200
const DAMAGE_COLLISION = 10

func _ready():
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	speed = MAX_VELX
	if !is_dead:
		vel.x = speed * direction
		#if direction == 1:
		#	$AnimatedSprite.flip_h = false
		#else:
		#	$AnimatedSprite.flip_h = true
		#$AnimatedSprite.play("Walk")
	vel = move_and_slide(vel,FLOOR)
	if is_on_wall():
			direction *= -1
	if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:							
					get_slide_collision(i).collider.hp_decrease(DAMAGE_COLLISION)
	


func dead():
	is_dead = true
	vel = Vector2(0,0)
	$CollisionShape2D.queue_free()
	#$AnimatedSprite.play("Dead")	
