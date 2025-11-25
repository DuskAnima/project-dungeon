extends Node

## Conecta la señal de EntityTerrainBus a un callable declarado, creando comunicación entre terrain.gd y entity.gd
## Esta función solo se utiliza para enviar y recibir señales sin datos
## Para utilizar esta función se debe declarar EntityTerrainBus.connect_bus_to_signal()
## y luego pasarle como argumento el callable que deberá ser detonado por la señal
func connect_bus_to_signal(callable : Callable) -> void:
	var signal_name : StringName = callable.get_method()
	if has_signal(signal_name):
		printerr("Aviso: La señal ", "<", signal_name, ">" ," ya existe y está conectada a ", 
		"<", Array(get_signal_connection_list(signal_name))[0].callable, ">",
		" no puede ser conectada a ", "<", callable, ">. Para evitar comportamientos impredecibles por duplicados, por favor, utilice otro nombre para su señal.") # Debugg
		return
	add_user_signal(signal_name) # Aun no hay nada conectado a la señal, hay que conectarla
	print("conectaré ", "<", signal_name, ">" ," a ", "<", callable, ">") # Debug
	connect(signal_name, callable)

## Conecta una señal a EntityTerrainBus, creando comunicación entre terrain.gd y entity.gd
## Esta función solo se utiliza para enviar y recibir señales sin datos.
## Para utilizar esta función se debe declarar la señal con la función connect(), luego pasarle como argumento
## EntityTerrain.set_clean_bus_connection
func connect_signal_to_bus(new_signal : String) -> void:
	var parsed_signal : StringName = "_on_" + new_signal
	if has_signal(parsed_signal):
		emit_signal(parsed_signal)


"""	var cont : int = 0
	for sig in get_signal_list():
		print(cont, sig)
		cont +=1"""
