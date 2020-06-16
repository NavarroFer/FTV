extends Control


const CANT_SKINS = 4
const MIN_VALUE_SKINS = 1
var skins = [preload("res://Sprites/Player/SSA.png"),preload("res://Sprites/Player/SSA_Blue.png"),preload("res://Sprites/Player/SSA_Green.png"),preload("res://Sprites/Player/SSA_Pink.png")]
var niveles = ["res://Scenes/World.tscn"
,"res://Scenes/World2.tscn"
,"res://Scenes/World3.tscn"
,"res://Scenes/WorldFinal.tscn"]

var selected = MIN_VALUE_SKINS

func _ready():
	$AnimationPlayer.play("walk")

func change_skin_r():
	if selected < CANT_SKINS:
		selected += 1
	set_skin()
	
func change_skin_l():
	if selected > MIN_VALUE_SKINS:
		selected -= 1
	set_skin()

func set_skin():
	$Control/Sprite.texture = skins[selected-1]

func _on_Button_pressed():
	#Escribir en un archivo el skin que eligio
	#para usar en todos los niveles
	Game.setSkin(selected)		
	get_tree().change_scene(niveles[int(Game.getNivel())])

func _on_Der_pressed():
	change_skin_r()

func _on_Izq_pressed():
	change_skin_l()
