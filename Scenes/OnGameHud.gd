extends CanvasLayer

signal jump
signal shot
signal action
signal idle
signal move_left
signal move_rigth

func _ready():
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
