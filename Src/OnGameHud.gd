extends CanvasLayer

signal jump
signal shot
signal action
signal idle
signal move_left
signal move_rigth
signal pause

func _ready():	
	print(get_viewport().size.x)
	print(get_viewport().size.y)
#	$Saltar.position.y = get_viewport().size.y*0.85
#	$Saltar.position.x = get_viewport().size.x*0.91
#	$Disparar.position.y = get_viewport().size.y*0.85
#	$Disparar.position.x = get_viewport().size.x*0.83
#	$Action.position.y = get_viewport().size.y*0.70
#	$Action.position.x = get_viewport().size.x*0.87
	
<<<<<<< HEAD:Scenes/OnGameHud.gd
#	$Joystick.position.x = get_viewport().size.x*0.1
#	$Joystick.position.y = get_viewport().size.y*0.85	
	
#	$HUD/HealthBar.rect_position.x = get_viewport().size.x*0.005
#	$HUD/HealthBar.rect_position.y = get_viewport().size.y*0.02
#	$HUD/ArmorBar.rect_position.x = get_viewport().size.x*0.005
#	$HUD/ArmorBar.rect_position.y = get_viewport().size.y*0.05
#	$HUD/TimerItem.rect_position.x = get_viewport().size.x*0.01
#	$HUD/TimerItem.rect_position.y = get_viewport().size.y*0.1
=======
	$Pause.position.y = get_viewport().size.y*0.02
	$Pause.position.x = get_viewport().size.x*0.575
	
	$Joystick.position.x = get_viewport().size.x*0.07
	$Joystick.position.y = get_viewport().size.y*0.55

	$HUD/HealthBar.rect_position.x = get_viewport().size.x*0.005
	$HUD/HealthBar.rect_position.y = get_viewport().size.y*0.02
	$HUD/ArmorBar.rect_position.x = get_viewport().size.x*0.005
	$HUD/ArmorBar.rect_position.y = get_viewport().size.y*0.05
	$HUD/TimerItem.rect_position.x = get_viewport().size.x*0.01
	$HUD/TimerItem.rect_position.y = get_viewport().size.y*0.1
>>>>>>> b49f3a06ee9c98ab42f95451f9883815f77f0f81:Src/OnGameHud.gd
	pass # Replace with function body.


func _on_Action_action():
	emit_signal("action")

func _on_Disparar_shot():
	emit_signal("shot")

func _on_Saltar_jump():
	emit_signal("jump")
	

func _on_Player_hp_changed(new_amount):
	$HUD._on_Player_hp_changed(new_amount)

func _on_Player_armor_change(armor):
	$HUD._on_Player_armor_change(armor)

func _on_Player_item_picked(tipo,time):
	$HUD._on_Player_item_picked(tipo,time)

func _on_Player_item_actived(tipo,time):
	$HUD._on_Player_item_actived(tipo,time)
	


func _on_Joystick_idle():
	emit_signal("idle")

func _on_Joystick_move_left():
	emit_signal("move_left")

func _on_Joystick_move_rigth():
	emit_signal("move_rigth")

<<<<<<< HEAD:Scenes/OnGameHud.gd
func _on_Pause_pressed():
	emit_signal("pause")
=======

func _on_PowerUp_item_tutorial():
	$HUD/TimerItem.resaltar()
>>>>>>> b49f3a06ee9c98ab42f95451f9883815f77f0f81:Src/OnGameHud.gd
