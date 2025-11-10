extends TileMapLayer

enum { IS_SOLID, IS_BREAKABLE }
enum { FLOOR, ICE_FLOOR, WALL }

var tile_data : TileData # Tile Custom Data
var tile_id : int # Tileset ID

var data : TileSet = self.tile_set
var tile_atlas : TileSetAtlasSource = data.get_source(1)
var borken_ice : TileData = tile_atlas.get_tile_data(Vector2i(0,0), 0)
var cracked_ice : TileData = tile_atlas.get_tile_data(Vector2i(1,0), 0)
var ice_floor : TileData = tile_atlas.get_tile_data(Vector2i(2,0), 0)

"""func _tile_events() -> void:
	if tile_data.get_custom_data_by_layer_id(FLOOR):
		print("piso")
	if tile_data.get_custom_data_by_layer_id(ICE_FLOOR):
		print("hielo")"""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(tile_atlas.resource_name)
	GridManager.set_terrain(self)

func _process(_delta: float) -> void:
	tile_data = GridManager.get_current_tile_data()
	tile_id = GridManager.get_current_tile_id()
	

func _input(_event: InputEvent) -> void:
	print(tile_id, " : ", tile_data)
	pass
	
	
	
# func break_ice(): -> void:
	
