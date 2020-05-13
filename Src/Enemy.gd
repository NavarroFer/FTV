extends KinematicBody2D

var gravity
export (int) var speed
var damage
const FLOOR = Vector2(0,-1)

var health
var vel = Vector2()
var direction = 1
var is_dead = false
var timer

signal enemy_dead

func _ready():	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(2)
	timer.connect("timeout",self,"_on_Timer_timeout")
	add_child(timer)
	pass # Replace with function body.

func dead():
	is_dead = true
	var array = filename.split("/",true,3)
	var subString = array[3]
	var array2 = str(array[3]).split(".",true,1)
	emit_signal("enemy_dead",str(array2[0]))
	vel = Vector2(0,0)
	$CollisionShape2D.queue_free()
	$AnimatedSprite.play("Dead")	
	timer.start()

func _physics_process(delta):
	if !is_dead:
		vel.x = speed * direction
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Walk")
		vel.y += gravity
		vel = move_and_slide(vel,FLOOR)
			
		if is_on_wall():
			direction *= -1
			$RayCast2D.position.x *= -1
		if $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:							
	#				get_slide_collision(i).collider.me_toco_Enemy($AnimatedSprite.flip_h)				
					get_slide_collision(i).collider.hp_decrease(damage)

func _on_Timer_timeout():
	queue_free()

func getDamage():
	return damage

func setDamage(new_amount):
	damage = new_amount

func getHealth():
	return health

func setHealth(new_amount):
	health = new_amount

func getGravity():
	return gravity

func setGravity(new_amount):
	gravity = new_amount

func getDirection():
	return direction
