extends Node

var vidas = 3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_vidas(cantidad):
	vidas = cantidad
	
func get_vidas():
	return vidas
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
