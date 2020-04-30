extends Node

signal max_changed(new_max)
signal changed(new_amount)
signal depleted()

#SETGET fuerza a que pases por los metodos "set_max" y "set_current"
export (int) var max_amount = 100 setget set_max
onready var current = max_amount setget set_current

func _ready():
	initialize()

func set_max(new_max):
	max_amount = max(1,new_max)
	emit_signal("max_changed",max_amount)

func get_current():
	return current

func set_current(new_value):
	current = new_value
	emit_signal("changed",current)

func initialize():
	emit_signal("max_changed",max_amount)
	emit_signal("changed",current)
