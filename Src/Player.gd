extends KinematicBody2D

const UP = Vector2(0,-1)
const MAX_SPEED_INICIAL = 160
const ACCELERATION = 50
const JUMP = 350
const GRAVITY = 10
const SHOT = preload("res://Scenes/Bullet.tscn")
const HP_INICIAL = 100
const POWER_VEL = 1
const POWER_SHOOT = 2


var motion = Vector2(0,0)
var is_atacking = false
var is_atacking_run = false
var rigth_signal = false
var left_signal = false
var jump_signal = false
var shoot_signal = false
var hp = HP_INICIAL
var is_dead = false
var max_speed = MAX_SPEED_INICIAL
var current_power_up

onready var Timer2 = $Timer2

signal moved_rigth
signal moved_left
signal moved_jump
signal moved_shoot
signal hp_change(health)


func _ready():	
	print("HP: ", hp)


func _physics_process(delta):	
	if is_dead == false:
		$CollisionShape2D.disabled = false
		motion.y += GRAVITY
		var friction = false
		if Input.is_action_pressed("move_r"):
			motion.x = min (motion.x+ACCELERATION,max_speed)
			if is_atacking == false:			
				$Sprite.flip_h = false;
				$Sprite.play("Run") #Same get_node("Sprite").play("Run")
				if sign($Position2D.position.x) < 0:
					$Position2D.position.x *= -1
			if(!rigth_signal && position.x > 200):
				rigth_signal = true
				emit_signal("moved_rigth")
		elif Input.is_action_pressed("move_l"):
			motion.x = max (motion.x-ACCELERATION,-max_speed)
			if is_atacking == false:			
				$Sprite.flip_h = true;
				$Sprite.play("Run")
				if sign($Position2D.position.x) > 0:
					$Position2D.position.x *= -1
			if(!left_signal && position.x > 700):
				left_signal = true
				emit_signal("moved_left")
		else:
			if is_on_floor() && is_atacking == false:
				$Sprite.play("Idle")
			friction = true
	
		if is_on_floor():
			if Input.is_action_pressed("move_up"):
				motion.y = -JUMP
				if(!jump_signal && position.x > 1200):
					jump_signal = true
					emit_signal("moved_jump")
			if friction:
				motion.x = lerp(motion.x, 0, 0.15)
		else:
			if is_atacking == false:
				if motion.y > 0:
						$Sprite.play("Jump")
				else:
						$Sprite.play("Fall")
			if friction:
				motion.x = lerp(motion.x, 0, 0.45)
	
		motion = move_and_slide(motion,UP)
		
		if Input.is_action_just_pressed("Shoot") && is_atacking == false:
			if(!shoot_signal && position.x > 1700):
				shoot_signal = true
				emit_signal("moved_shoot")
			if is_on_floor():
				motion.x = 0
			is_atacking = true
			$Sprite.play("Shoot")
			var shot = SHOT.instance()
			if sign($Position2D.position.x) == 1:
				shot.set_bullet_direction(1)
			else:
				shot.set_bullet_direction(-1)
			get_parent().add_child(shot)
			shot.position = $Position2D.global_position
		if get_slide_count() > 0:			
			for i in range (get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					hp_decrease()

func dead():
	is_dead = true	
	motion = Vector2(0,0)
	$Sprite.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start()		

func hp_decrease():
	if($Timer2.is_stopped()):		
		hp -= 50
		emit_signal("hp_change",str(hp))
		print("Hp - 50: ",hp)
		$Timer2.start()		
		$Sprite.play("Inv")
	if hp <= 0:
		dead()		
		
func _on_Sprite_animation_finished():
	is_atacking = false


func _on_Timer_timeout():
	get_tree().reload_current_scene()


#POWER UPS
func picked_power_up_velocity():
	$TimerPowerUps.start()
	max_speed = MAX_SPEED_INICIAL*1.5 
	current_power_up = POWER_VEL

func picked_power_up_invulneravility():
	$Timer2.start(5)
	$Sprite.play("Inv")	

func _on_TimerPowerUps_timeout():
	match current_power_up:
		POWER_VEL: 
			max_speed = MAX_SPEED_INICIAL
