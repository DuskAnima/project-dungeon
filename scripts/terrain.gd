extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GridManager.get_terrain(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
