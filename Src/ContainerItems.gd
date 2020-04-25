extends NinePatchRect

const VACUNA = preload("res://Sprites/PowerUps/Vacuna.png")
const BARBIJO = preload("res://Sprites/PowerUps/Barbijo.png")
const JABON = preload("res://Sprites/PowerUps/Jabon.png")
const BOTAS = preload("res://Sprites/PowerUps/Bota.png")
var time_left
var tipo_picked = 0
var time_picked
func _ready():
	$Picked.texture = null
	$Active.texture = null
	$TimerPowerUp.wait_time = 1

func setPicked(tipo,time):
	if(tipo != 2):
		time_picked = time
	else:
		time_picked = 0
	tipo_picked = tipo
	if($TimerPowerUp.is_stopped()):
		setSeg(time_picked)
	match tipo:
		1: $Picked.texture = VACUNA
		2: $Picked.texture = BARBIJO
		3: $Picked.texture = JABON
		4: $Picked.texture = BOTAS
	
	

func setActive(tipo,time):
	if(tipo_picked != 2):
		time_left = time - 1
		$TimerPowerUp.start()	
	else:
		$Active.texture = null		
	tipo_picked = 0
	$Picked.texture = null
	match tipo:
		1: $Active.texture = VACUNA		
		3: $Active.texture = JABON
		4: $Active.texture = BOTAS
	
func setSeg(time):
	$Seg.text = str(time)


func _on_TimerPowerUp_timeout():
	setSeg(time_left)
	time_left -= 1
	if(time_left+1 <= 0):
		$TimerPowerUp.stop()			
		$Active.texture = null
		if(tipo_picked != 0):
			setSeg(time_picked)	
		else:
			setSeg(0) 
	else:
		$TimerPowerUp.start(1)		
	
