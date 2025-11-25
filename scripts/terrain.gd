extends TileMapLayer

enum Data { IS_SOLID, IS_BREAKABLE }
enum { WALL, ICE, FLOOR }

var current_entity_position : Vector2i # Posición actual de entity
var last_entity_position : Vector2i # Posicion anterior de entity
var tile_data : TileData # Tile Custom Data
var tile_id : int # Tileset ID

var data : TileSet = self.tile_set
var tile_atlas : TileSetAtlasSource = data.get_source(1)
var tile_name : String = tile_atlas.resource_name
var borken_ice : TileData = tile_atlas.get_tile_data(Vector2i(0,0), 0)
var cracked_ice : TileData = tile_atlas.get_tile_data(Vector2i(1,0), 0)
var ice_floor : TileData = tile_atlas.get_tile_data(Vector2i(2,0), 0)

func _ready() -> void:
	GridManager.set_terrain(self) # Entrega terreno para crear el grid
	# Conecta el bus a la función de notificación de movimiento 
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)
	EntityTerrainBus.connect_bus_to_signal(_on_movement_finished)

# Estoy recibiendo automáticamente la data de cada tile, independiente de cual sea
func _tile_handler() -> void:
	match tile_id:
		WALL:
			print("Muro")
		ICE:
			print("Hielo")
		FLOOR:
			print("piso")
	
## Bloque que ejecuta código en base al aviso de que el movimiento de una entidad ha finalizado
## Con esto se evitan checks duplicados o innecesarios. 
## Notifiación creada por EntityTerrainBus
func _on_movement_finished() -> void:
	print("terminé de caminar")
	pass
	
	

## Bloque que ejecuta código en base al aviso de que el movimiento de una entidad va a comenzar
## Con esto se evitan checks duplicados o innecesarios. 
## Notifiación creada por EntityTerrainBus
func _on_movement_started() -> void:
	pass
	print("voy a caminar")
	_get_entity_tile_data()
	_tile_handler()

## Obtiene y asigna la información del actual tile utilizado por entity (con un efecto secundario).
## Además actualiza tanto la posición actual como la posición anterior de entity.
func _get_entity_tile_data() -> void:
	last_entity_position = current_entity_position # Almacena la posición anterior del personaje
	# Luego de reposicionarse, se actualiza la información del tile
	current_entity_position = GridManager.get_entity_position() 
	tile_id = get_cell_source_id(current_entity_position) # Retorna el ID del tile
	tile_data = get_cell_tile_data(current_entity_position) # Retorna la información del tile
