extends Terrain

func _ready() -> void:
	GridManager.set_wall(self)
