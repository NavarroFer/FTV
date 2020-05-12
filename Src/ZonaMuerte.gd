extends Area2D

func _on_ZonaMuerte_body_entered(body):
	if body.name == "Player":
		body.dead()
