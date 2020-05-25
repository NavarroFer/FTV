extends TouchScreenButton

var radius = Vector2(50, 50)
var boundary = 144
var ongoing_drag = -1
var return_accel = 20
var threshold = 10
var center = (Vector2(0,0) - radius ) - position
var mov = 0


func _ready():
	position.x = -50
	
func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius ) - position
		position += pos_difference * return_accel * delta
		

func get_button_pos():
	return position + radius

func _input(event):
	if position.x <= -48 and position.x >= -52 :
		mov = 0
	elif position.x < -52:
		mov = -1
	else:
		mov = 1
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()
		if event_dist_from_centre <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - radius * global_scale)		
			
			if get_button_pos().length() > boundary:
				set_position( get_button_pos().normalized() * boundary - radius )	
			
			ongoing_drag = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

func get_value():
	return mov


func _on_Joystick_Button_released():
	mov = 0
