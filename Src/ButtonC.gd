extends Control

export(int) var tipo
signal jump
signal shot
signal action

func _ready():
	init()
	pass # 

func init():
	$Button.setTipo(tipo)
	$Button.init()	
	pass
	
func is_pressed():
	return $Button.is_pressed()


func _on_Button_action():
	emit_signal("action")
	
func _on_Button_jump():
	emit_signal("jump")
	
func _on_Button_shot():
	emit_signal("shot")
