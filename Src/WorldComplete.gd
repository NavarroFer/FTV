extends Area2D
export(String,FILE,"*.tscn") var next_world

func _ready():
	$AnimationPlayer.play("Vena")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && Input.is_action_pressed("Action"):
			get_tree().change_scene(next_world)
