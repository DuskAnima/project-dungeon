extends Node
## Bus que media las señales entre entity.gd y terrain.gd.

## Conecta la señal de EntityTerrainBus a un callable declarado, creando comunicación entre terrain.gd y entity.gd
## Esta función solo se utiliza para recibir señales sin datos
## 0. El Callable que será el receptor de la señal solo puede ser declarado una vez, sin importar en cual de los
## dos scripts (terrain.gd o entity.gd) sea declarado.
## 1. En en _on_ready(), se debe declarar EntityTerrainBus.connect_bus_to_signal(<trigger>). 
## 2. El trigger a declarar es el Callable que recibirá la señal.
## 3. La convención de nombres es on_<trigger>() en el receptor y etbus.emit(<trigger>) en el emisor. 
## y es OBLIGATORIA para que las señales funcionen.
func connect_bus_to_signal(callable : Callable) -> void:
	var signal_name : StringName = callable.get_method()
	if has_signal(signal_name):
		printerr("Aviso: La señal ", "<", signal_name, ">" ," ya existe y está conectada a ", 
		"<", Array(get_signal_connection_list(signal_name))[0].callable, ">", #debug
		" no puede ser conectada a ", "<", callable, ">. Para evitar comportamientos impredecibles por duplicados, por favor, utilice otro nombre para su señal.") # Debugg
		return
	add_user_signal(signal_name) # Aun no hay nada conectado a la señal, hay que conectarla
	#print("conectaré ", "<", signal_name, ">" ," a ", "<", callable, ">") # Debug
	connect(signal_name, callable)

## Emite una señal a EntityTerrainBus, creando comunicación entre terrain.gd y entity.gd
## Esta función solo se utiliza para enviar señales sin datos.
## 0. Se recomienda declarar la señal de conexión standard con el nombre "etbus".
## 1. En en _on_ready(), se debe declarar la señal etbus.connect(EntityTerrain.connect_signal_to_bus).
## 2. "etbus" solo debe emitir el nombre de la señal trigger que se desea conectar entre 
## entity.gd y terrain.gd. 3. La convención de nombres es etbus.emit(<trigger>) en el emisor y on_<trigger>() 
## en el receptor y es OBLIGATORIA para que las señales funcionen.
func connect_signal_to_bus(new_signal : StringName) -> void:
	var parsed_signal : StringName = "_on_" + new_signal
	if has_signal(parsed_signal):
		emit_signal(parsed_signal)

# Debug para imprimir lista de señales 
"""	var cont : int = 0
	for sig in get_signal_list():
		print(cont, sig)
		cont +=1"""
