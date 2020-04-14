extends KinematicBody2D

const UP = Vector2(0,-1)
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP = 900
const GRAVITY = 50
var motion = Vector2(0,0)


func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	if Input.is_action_pressed("move_r"):
		motion.x = min (motion.x+ACCELERATION,MAX_SPEED)
		$Sprite.flip_h = false;
		$Sprite.play("Run") #Same get_node("Sprite").play("Run")
	elif Input.is_action_pressed("move_l"):
		motion.x = max (motion.x-ACCELERATION,-MAX_SPEED)
		$Sprite.flip_h = true;
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true

	if is_on_floor():
		if Input.is_action_pressed("move_up"):
			motion.y = -JUMP
		if friction:
			motion.x = lerp(motion.x, 0, 0.15)
	else:
		if motion.y > 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.45)

	motion = move_and_slide(motion,UP)
	pass
