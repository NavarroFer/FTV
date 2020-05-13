extends CanvasLayer

signal jump
signal shot
signal action
signal idle
signal move_left
signal move_rigth

func _ready():	
	print(get_viewport().size.x)
	print(get_viewport().size.y)
	$Saltar.position.y = get_viewport().size.y*0.55
	$Saltar.position.x = get_viewport().size.x*0.60
	$Disparar.position.y = get_viewport().size.y*0.55
	$Disparar.position.x = get_viewport().size.x*0.55
	$Action.position.y = get_viewport().size.y*0.45
	$Action.position.x = get_viewport().size.x*0.575
	
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


func _on_PowerUp_item_tutorial():
	$HUD/TimerItem.resaltar()
