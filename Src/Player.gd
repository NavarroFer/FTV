extends KinematicBody2D

#CONSTANTES
const UP = Vector2(0,-1)
const MAX_SPEED_INICIAL = 160
const ACCELERATION = 50
const JUMP = 350
const GRAVITY = 10
const DAMAGE_INICIAL = 30
const ARMOR_INICIAL = 0
const SHOT = preload("res://Scenes/Bullet.tscn")
const FINAL_BG = preload("res://Sprites/Background/100334.png")
const HP_INICIAL = 100
const VACUNA = 1
const BARBIJO = 2
const JABON = 3
const BOTAS = 4
const SPEED_SHOT = 250

#VARIABLES
var motion = Vector2(0,0)
var inv
var left
var rigth
var idle
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
var damage_player = DAMAGE_INICIAL
var current_power_up = 0
var time_power_up = 0
var has_item_picked = false
onready var Joystick = get_parent().get_node("OGH/Joystick/Joystick/Joystick_Button")
onready var Button_Jump = get_parent().get_node("OGH/Saltar")
onready var Button_Shot = get_parent().get_node("OGH/Disparar")
onready var Button_Action = get_parent().get_node("OGH/Action")
onready var Timer2 = $Timer2

#SIGNALS
signal moved_rigth
signal moved_left
signal moved_jump
signal moved_shoot
signal hp_changed(new_amount)
signal armor_change(armor)
signal item_actived
signal item_picked


func _ready():	
	motion.x = 0
	motion.y = 0	
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
		#if Input.is_action_pressed("move_r"):
		if Joystick.get_value() > 0 or Input.is_action_pressed("move_r"):
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
		#elif Input.is_action_pressed("move_l"):
		elif Joystick.get_value() < 0 or Input.is_action_pressed("move_l"):
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
			if Button_Jump.is_pressed() or Input.is_action_pressed("move_up"):
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
		
		if Input.is_action_pressed("Shoot") or Button_Shot.is_pressed() && is_atacking == false :
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
#				shot.init(1,damage_player,SPEED_SHOT,0)
				shot.initAngle(SPEED_SHOT,0)
			else:
#				shot.init(1,damage_player,-SPEED_SHOT,0)
				shot.initAngle(-SPEED_SHOT,0)
			get_parent().add_child(shot)
			shot.position = $Position2D.global_position
		if get_slide_count() > 0:			
			for i in range (get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					hp_decrease(get_slide_collision(i).collider.getDamage())
	if(Button_Action.is_pressed() && has_item_picked == true):
		emit_signal("item_actived",current_power_up,time_power_up)
		active_power_up()
		has_item_picked = false


func dead():
	is_dead = true	
	motion = Vector2(0,0)
	$Animacion.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start()		

func hp_decrease(damage):
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
	

func _on_Timer_timeout():
	get_tree().reload_current_scene()


#POWER UPS
func active_power_up():
	$TimerPowerUps.wait_time = time_power_up
	match current_power_up:
		VACUNA:
			$Timer2.start()
			inv = true
		BARBIJO:
			if($Armor.get_current() + 40 > 100):
				$Armor.set_current(100)
			else:
				$Armor.set_current($Armor.get_current() + 40)
		JABON:
			$TimerPowerUps.start()			
			damage_player = DAMAGE_INICIAL * 2	
		BOTAS:
			$TimerPowerUps.start()
			max_speed = MAX_SPEED_INICIAL*1.5 
			current_power_up = BOTAS

func picked_power_up(Tipo, time):	
	has_item_picked = true
	emit_signal("item_picked",Tipo, time)
	current_power_up = Tipo
	time_power_up = time
			

func _on_TimerPowerUps_timeout():
	match current_power_up:		
		JABON:
			damage_player = DAMAGE_INICIAL	
		BOTAS:
			max_speed = MAX_SPEED_INICIAL

func _on_Health_changed(new_amount_h):
	emit_signal("hp_changed",new_amount_h)

func _on_Armor_changed_armor(new_amount_a):
	emit_signal("armor_change",new_amount_a)

func _on_Animacion_animation_finished(anim_name):
	is_atacking = false
	$Animacion.play("Idle")

func _on_Timer2_timeout():	
	$Animacion.play("Idle")
	$Sprite2.visible = true
	inv = false


func _on_WorldFinal_WorldFinal_started():
	$ParallaxBackground/Fondo4.texture = preload("res://Sprites/Background/BG_FinalBoss.png")

	
func _on_Joystick_move_left():
	left = true
	rigth = false
	idle = false

func _on_Joystick_move_rigth():
	rigth = true
	left = false
	idle = false


func _on_Joystick_idle():
	idle = true
	left = false
	rigth = false


func _on_Disparar_action():
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
		shot.initAngle(SPEED_SHOT,0)
	else:
		shot.initAngle(-SPEED_SHOT,0)
	get_parent().add_child(shot)
	shot.position = $Position2D.global_position

