extends Area2D
export(String,FILE,"*.tscn") var next_world

onready var Button_Action = get_parent().get_node("OGH/Action")
signal level_completed

func _ready():
	$AnimationPlayer.play("Vena")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && (Button_Action.is_pressed() or Input.is_action_pressed("Action")):
			#BackgroundLoad.load_scene("res://Scenes/World2.tscn")
			emit_signal("level_completed")
			get_tree().change_scene(next_world)
