extends Terrain


func _ready() -> void:
	GridManager.set_surface(self) # Entrega terreno para crear el grid
	# Conecta el bus a la función de notificación de movimiento 
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)
	EntityTerrainBus.connect_bus_to_signal(_on_movement_finished)

## Bloque que ejecuta código en base al aviso de que el movimiento de una entidad ha finalizado
## Con esto se evitan checks duplicados o innecesarios. 
## Notifiación creada por EntityTerrainBus
func _on_movement_finished() -> void:
	_tile_handler()

## Bloque que ejecuta código en base al aviso de que el movimiento de una entidad va a comenzar
## Con esto se evitan checks duplicados o innecesarios. 
## Notifiación creada por EntityTerrainBus
func _on_movement_started() -> void:
	_get_entity_tile_data()
