extends TileMapLayer

enum Data { IS_SOLID, IS_BREAKABLE }
enum { WALL, ICE, FLOOR }

var current_entity_position : Vector2i # Posición actual de entity
var last_entity_position : Vector2i # Posicion anterior de entity
var tile_id : int # ID de tile habitado por entity
var terrain_tile_data : TileData # Custom Data del tile habitado por entity
var tile_atlas : TileSetAtlasSource # Referencia al Atlas TileSet que está siendo utilizado
var tile_atlas_coords : Vector2i # Referencia posicional del tile en uso dentro del Atlas

#var tile_name : String = tile_atlas.resource_name

func _ready() -> void:
	GridManager.set_terrain(self) # Entrega terreno para crear el grid
	# Conecta el bus a la función de notificación de movimiento 
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)
	EntityTerrainBus.connect_bus_to_signal(_on_movement_finished)

# Estoy recibiendo automáticamente la data de cada tile, independiente de cual sea
func _tile_handler() -> void:
	tile_break_system()
	match tile_id:
		WALL:
			print("Qué haces aquí, Fred")
		ICE:
			pass
		FLOOR:
			pass


func tile_break_system() -> void:
	var breakable : bool = terrain_tile_data.get_custom_data_by_layer_id(Data.IS_BREAKABLE)
	if breakable:
		print("antes atlas coords: ", tile_atlas_coords)
		var tile_breaker : Vector2i = tile_atlas_coords + Vector2i(1,0)
		print("despues atlas coords: ", tile_atlas_coords, ". tile breaker", tile_breaker)
		set_cell(current_entity_position, tile_id, tile_breaker)


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

## Obtiene y asigna la información del actual tile utilizado por entity.
## Además actualiza tanto la posición actual como la posición anterior de entity.
func _get_entity_tile_data() -> void: # Almacena la posición anterior del personaje
	# Luego de reposicionarse, se actualiza la información del tile
	last_entity_position = GridManager.last_position
	current_entity_position = GridManager.next_position
	tile_id = get_cell_source_id(current_entity_position) # Asigna el ID del tile
	terrain_tile_data = get_cell_tile_data(current_entity_position) # Asigna la información del tile
	tile_atlas = tile_set.get_source(tile_id) # Asigna el Atlas al que corresponde el tile
	tile_atlas_coords = get_cell_atlas_coords(current_entity_position)
