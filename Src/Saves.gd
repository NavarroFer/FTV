extends Node

const SAVE_PATH = "user://saves.sav"
#const SAVE_PATH = "res://saves.sav"

var data = {
"skin":"1",
"level":"1",
"world":"1"
}


func save_game(data):
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_line(to_json(data))
	file.close()
	

func load_game():
	var data = {}
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		return # Error! No hay archivo que guardar
	file.open(SAVE_PATH, File.READ)
	data = parse_json(file.get_as_text())
	#data = parse_json(save_game.get_line())
	file.close()
	return data
