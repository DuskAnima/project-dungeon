extends TileMapLayer

var data : TileSet = self.tile_set
var tile_atlas : TileSetAtlasSource = data.get_source(1)
var borken_ice : TileData = tile_atlas.get_tile_data(Vector2i(0,0), 0)
var cracked_ice : TileData = tile_atlas.get_tile_data(Vector2i(1,0), 0)
var ice_floor : TileData = tile_atlas.get_tile_data(Vector2i(2,0), 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(tile_atlas.resource_name)
	print(borken_ice)
	print(cracked_ice)
	print(ice_floor)
	
	GridManager.get_terrain(self)
