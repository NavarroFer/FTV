extends Control

const SIMULATED_DELAY_SEC = 0.1
var thread = null
onready var progress = $TextureProgress

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()
	# Seteo la cantidad de pasos.
	progress.call_deferred("set_max", total)
	var res = null
	while true: #Itero hasta completar la carga
		# Actualizo la barra. Uso call deferred, para ir al hilo principal.
		progress.call_deferred("set_value", ril.get_stage())
		# Delay
		OS.delay_msec(int(SIMULATED_DELAY_SEC * 1000.0))
		# Paso de carga
		var err = ril.poll()
		# Si esta bien, sigue cargando. Sino hay error
		if err == ERR_FILE_EOF:
			# Fin de archivo, finalizo la carga
			res = ril.get_resource()
			break
		elif err != OK:
			# Otro error. Muestro mensaje
			print("Hubo error al cargar la escena")
			break
	# Envia el recurso obtenido
	call_deferred("_thread_done", res)

func _thread_done(resource):
	assert(resource)
	# EN WINDOWS, es requerido esperar a que termine el hilo
	thread.wait_to_finish()
	# Oculto la Barra
	progress.hide()
	$TextureRect.hide()
	# Cambio de Escena
	var new_scene = resource.instance()
	get_tree().current_scene.free()
	get_tree().current_scene = null
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

func load_scene(path):
	thread = Thread.new()
	thread.start( self, "_thread_load", path)
	raise() # Muestra encima
	progress.visible = true
	
func back_to_menu():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://tilesets/menu.tscn")
