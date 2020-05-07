extends Area2D
export(String,FILE,"*.tscn") var next_world

onready var Button_Action = get_parent().get_node("CanvasLayer/Action")

func _ready():
	$AnimationPlayer.play("Vena")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && Button_Action.is_pressed():
			#BackgroundLoad.load_scene("res://Scenes/World2.tscn")
			get_tree().change_scene(next_world)
