extends TileMapLayer

enum Data { IS_SOLID, IS_BREAKABLE }
enum Floor { FLOOR, ICE_FLOOR, WALL }

var entity_position : Vector2i # Posición actual de entity

var tile_data : TileData # Tile Custom Data
var tile_id : int # Tileset ID

var data : TileSet = self.tile_set
var tile_atlas : TileSetAtlasSource = data.get_source(1)
var tile_name : String = tile_atlas.resource_name
var borken_ice : TileData = tile_atlas.get_tile_data(Vector2i(0,0), 0)
var cracked_ice : TileData = tile_atlas.get_tile_data(Vector2i(1,0), 0)
var ice_floor : TileData = tile_atlas.get_tile_data(Vector2i(2,0), 0)

"""func _tile_events() -> void:
	if tile_data.get_custom_data_by_layer_id(FLOOR):
		print("piso")
	if tile_data.get_custom_data_by_layer_id(ICE_FLOOR):
		print("hielo")"""

func _ready() -> void:
	GridManager.set_terrain(self) # Entrega terreno para crear el grid
	# Conecta el bus a la función de notificación de movimiento finalizado
	EntityTerrainBus.connect_bus_to_signal_clean(_on_entity_movement_finished)

# Recibe una notificación de entity.gd a través del BUS sobre la consolidación del movimiento del entity.
## Con esto se evitan checks duplicados o innecesarios. 
func _on_entity_movement_finished() -> void:
	_get_entity_tile_data()

func _get_entity_tile_data() -> TileData:
	# Luego de reposicionarse, se actualiza la información del tile
	entity_position = GridManager.get_entity_position() 
	return self.get_cell_tile_data(entity_position) # Retorna la información del tile
