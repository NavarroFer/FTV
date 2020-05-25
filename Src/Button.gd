extends TouchScreenButton

const JUMP = preload("res://Sprites/VirtualJoystickPack/ButtonJump.png") 
const JUMP_P = preload("res://Sprites/VirtualJoystickPack/ButtonJumpP.png")
const SHOT = preload("res://Sprites/VirtualJoystickPack/ButtonShoot.png") 
const SHOT_P = preload("res://Sprites/VirtualJoystickPack/ButtonShootP.png")
const ACTION = preload("res://Sprites/VirtualJoystickPack/ButtonAction.png") 
const ACTION_P = preload("res://Sprites/VirtualJoystickPack/ButtonActionP.png")

var tipo
signal jump
signal shot
signal action

func setTipo(t):
	tipo = t
	
func init():
	if tipo == 0:
		set_texture(JUMP)
		set_texture_pressed(JUMP_P)
	elif tipo == 1:
		set_texture(SHOT)
		set_texture_pressed(SHOT_P)
	elif tipo == 2:
		set_texture(ACTION)
		set_texture_pressed(ACTION_P)


func _on_Button_pressed():
	if tipo == 0:
		emit_signal("jump")
	elif tipo == 1:
		emit_signal("shot")
	elif tipo == 2:
		emit_signal("action")
