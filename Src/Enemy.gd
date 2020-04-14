extends KinematicBody2D

export (int) var gravity
export (int) var speed
const FLOOR = Vector2(0,-1)

var vel = Vector2()
var direction = 1
var is_dead = false
var timer

func _ready():	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(2)
	timer.connect("timeout",self,"_on_Timer_timeout")
	add_child(timer)
	pass # Replace with function body.

func dead():
	is_dead = true
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
				get_slide_collision(i).collider.hp_decrease()

func _on_Timer_timeout():
	queue_free()



