extends Node

signal clean_signal()

## Conecta EntityTerrainBus a un callable declarado, creando comunicación entre terrain.gd y entity.gd
## Esta función solo se utiliza para enviar y recibir señales sin datos
## Para utilizar esta función se debe declarar EntityTerrainBus.get_clean_bus_connection()
## y luego pasarle como argumento el callable que deberá detonar la señal
func connect_bus_to_signal_clean(callable : Callable) -> void:
	clean_signal.connect(callable)

## Conecta una señal a EntityTerrainBus, creando comunicación entre terrain.gd y entity.gd
## Esta función solo se utiliza para enviar y recibir señales sin datos.
## Para utilizar esta función se debe declarar la señal con la función connect(), luego pasarle como argumento
## EntityTerrain.set_clean_bus_connection
func connect_signal_to_bus_clean() -> void:
	emit_signal("clean_signal")
