extends KinematicBody2D

#CONSTANTES
const UP = Vector2(0,-1)
const MAX_SPEED_INICIAL = 160
const ACCELERATION = 50
const JUMP = 350
const GRAVITY = 10
const DAMAGE_INICIAL = 50
const ARMOR_INICIAL = 0
const SHOT = preload("res://Scenes/Bullet.tscn")
const HP_INICIAL = 100
const POWER_INV = 1
const POWER_ARMOR = 2
const POWER_SHOOT = 3
const POWER_VEL = 4

#VARIABLES
var motion = Vector2(0,0)
var inv
var is_atacking = false
var is_atacking_run = false
var rigth_signal = false
var left_signal = false
var jump_signal = false
var shoot_signal = false
var is_dead = false
var hp = HP_INICIAL
var armor = ARMOR_INICIAL
var max_speed = MAX_SPEED_INICIAL
var damage = DAMAGE_INICIAL
var current_power_up
var have_item_active = false
var have_item = false
onready var Timer2 = $Timer2

#SIGNALS
signal moved_rigth
signal moved_left
signal moved_jump
signal moved_shoot
signal hp_changed(new_amount)
signal armor_change(armor)


func _ready():	
	$Health.set_max(100)
	$Health.set_current(HP_INICIAL)
	$Armor.set_max(100)
	$Armor.set_current(ARMOR_INICIAL)


#MOVEMENT
func _physics_process(delta):	
	if is_dead == false:
		$CollisionShape2D.disabled = false
		motion.y += GRAVITY
		var friction = false
		if Input.is_action_pressed("move_r"):
			motion.x = min (motion.x+ACCELERATION,max_speed)
			if is_atacking == false:			
				$Sprite2.flip_h = false;
				if(inv == true):
					$Animacion.play("Run_INV")
				else:
					$Animacion.play("Run") #Same get_node("Sprite").play("Run")
			if sign($Position2D.position.x) < 0:
				$Position2D.position.x *= -1
			if(!rigth_signal && position.x > 200):
				rigth_signal = true
				emit_signal("moved_rigth")
		elif Input.is_action_pressed("move_l"):
			motion.x = max (motion.x-ACCELERATION,-max_speed)
			if is_atacking == false:			
				$Sprite2.flip_h = true;
				if(inv == true):
					$Animacion.play("Run_INV")
				else:
					$Animacion.play("Run")
			if sign($Position2D.position.x) > 0:
				$Position2D.position.x *= -1
			if(!left_signal && position.x > 700):
				left_signal = true
				emit_signal("moved_left")
		else:
			if is_on_floor() && is_atacking == false:
				if(inv == true):
					$Animacion.play("Idle_INV")
				else:
					$Animacion.play("Idle")				
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
					if(inv == true):
						$Animacion.play("Jump_INV")
					else:
						$Animacion.play("Jump")
				else:
					if(inv == true):
						$Animacion.play("Fall_INV")
					else:
						$Animacion.play("Fall")
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
			if(inv == true):
				$Animacion.play("Shoot_INV")
			else:
				$Animacion.play("Shoot")
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
					hp_decrease(get_slide_collision(i).collider.getDamage())

func dead():
	is_dead = true	
	motion = Vector2(0,0)
	$Animacion.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start()		

func hp_decrease(damage):
	print($Armor.get_current())
	print($Health.get_current())
	if($Timer2.is_stopped()):		
		if($Armor.get_current() - damage < 0):
			$Armor.set_current(0)			
			$Health.set_current($Health.get_current() - (damage - armor))
		else:
			$Armor.set_current($Armor.get_current() - damage)			
		$Timer2.start(2)
		inv = true		
	if $Health.get_current() <= 0:
		dead()		
		
func _on_Sprite_animation_finished():
	is_atacking = false
	pass
	


func _on_Timer_timeout():
	get_tree().reload_current_scene()


#POWER UPS
func picked_power_up_velocity():
	$TimerPowerUps.start(15)
	max_speed = MAX_SPEED_INICIAL*1.5 
	current_power_up = POWER_VEL

func picked_power_up_invulneravility():
	$Timer2.start(5)
	inv = true
	

func picked_power_up_armor():	
	$Armor.set_current(50)	
	
func picked_power_up_damage():
	$TimerPowerUps.start(15)
	damage = DAMAGE_INICIAL * 2
	
func _on_TimerPowerUps_timeout():
	match current_power_up:		
		POWER_SHOOT:
			damage = DAMAGE_INICIAL	
		POWER_VEL:
			max_speed = MAX_SPEED_INICIAL


func _on_Health_changed(new_amount_h):
	emit_signal("hp_changed",new_amount_h)


func _on_Armor_changed_armor(new_amount_a):
	emit_signal("armor_change",new_amount_a)


func _on_Animacion_animation_finished(anim_name):
	is_atacking = false
	$Animacion.play("Idle")
	pass


func _on_Timer2_timeout():
	print("Termino el tiempo de inv")
	$Animacion.play("Idle")
	$Sprite2.visible = true
	inv = false
