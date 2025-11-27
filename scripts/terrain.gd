extends TileMapLayer

enum Data { IS_SOLID, IS_BREAKABLE }
enum { WALL, ICE, FLOOR }

var current_entity_position : Vector2i # Posición actual de entity
var last_entity_position : Vector2i # Posicion anterior de entity
var tile_data : TileData # Custom Data del tile habitado por entity
var tile_id : int # ID de tile habitado por entity
var tile_atlas : TileSetAtlasSource # Representación del Atlas que está siendo habitado

#var tile_name : String = tile_atlas.resource_name

## Datos de los tipos de hielo
"""
var borken_ice : TileData = tile_atlas.get_tile_data(Vector2i(0,0), 0)
var cracked_ice : TileData = tile_atlas.get_tile_data(Vector2i(1,0), 0)
var ice_floor : TileData = tile_atlas.get_tile_data(Vector2i(2,0), 0)
"""
func _ready() -> void:
	GridManager.set_terrain(self) # Entrega terreno para crear el grid
	# Conecta el bus a la función de notificación de movimiento 
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)
	EntityTerrainBus.connect_bus_to_signal(_on_movement_finished)

# Estoy recibiendo automáticamente la data de cada tile, independiente de cual sea
func _tile_handler() -> void:
	var breakable : bool = tile_data.get_custom_data_by_layer_id(Data.IS_BREAKABLE)
	
	match tile_id:
		WALL:
			print("Qué haces aquí, Fred")
		ICE:
			if breakable:
				print("se te rompe el piso wacho")
				print(tile_atlas)
				set_cell(current_entity_position, tile_id, Vector2(0,0))
		FLOOR:
			pass
	
## Bloque que ejecuta código en base al aviso de que el movimiento de una entidad ha finalizado
## Con esto se evitan checks duplicados o innecesarios. 
## Notifiación creada por EntityTerrainBus
func _on_movement_finished() -> void:
	pass
	

## Bloque que ejecuta código en base al aviso de que el movimiento de una entidad va a comenzar
## Con esto se evitan checks duplicados o innecesarios. 
## Notifiación creada por EntityTerrainBus
func _on_movement_started() -> void:
	pass
	_get_entity_tile_data()
	_tile_handler()


## Obtiene y asigna la información del actual tile utilizado por entity (con un efecto secundario).
## Además actualiza tanto la posición actual como la posición anterior de entity.
func _get_entity_tile_data() -> void: # Almacena la posición anterior del personaje
	# Luego de reposicionarse, se actualiza la información del tile
	last_entity_position = GridManager.last_position
	current_entity_position = GridManager.next_position
	#print("estuve en: ", last_entity_position, ". estoy en ", current_entity_position)
	tile_id = get_cell_source_id(current_entity_position) # Asigna el ID del tile
	tile_data = get_cell_tile_data(current_entity_position) # Asigna la información del tile
	tile_atlas = tile_set.get_source(tile_id) # Asigna el Atlas al que corresponde el tile
