extends Node
# Tile size: 32 pixels
# Origen 0,0
# Representación lógica del mapa: Diccionario
# Capas lógicas separadas terrain/objects/entities/aux
const TILE_SIZE : int = 32
var terrain : TileMapLayer
var entity : Entity
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Grid Manager")

func _input(_event: InputEvent) -> void:
	move_entity()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if terrain != null:
		# Usando local_to_map se revela la posición del jugador en el TileMapLayer basado 
		# en la posición local de los tiles
		#print("player is in ", terrain.local_to_map(entity.get_position())) 
		pass

## Recibe self del terreno para manipularlo como grid
func get_terrain(tilemap: TileMapLayer) -> void:
	terrain = tilemap

# Para probar la fución se está limitando al player, pero la idea es que reciba las entidades en general
## add_entity() -> Recibe el self de la entidad que se quiere establecer en el grid
func add_entity(new_entity: CharacterBody2D) -> void:
	entity = new_entity
	
func move_entity() -> void:
	var e_direction : Vector2i = entity.get_direction()
	if e_direction != Vector2i.ZERO:
		var map_position : Vector2i = terrain.local_to_map(entity.get_position()) # Map
		var new_position : Vector2i = map_position + e_direction # New pos Map
		var new_local_position : Vector2 = terrain.map_to_local(new_position) # Parse Map to Local
		entity.position = new_local_position # Set local position based on Map
		
		
		# Debo calcular la siguiente posición como Map
		# Luego ese Map lo transformo a local
		# Luego local se lo asigno al personaje
		# Itero
		print("direction: ", e_direction)
		print("new position: ", new_position)
		print("new local: ", new_local_position)
		
		print("position", terrain.local_to_map(entity.get_position()))
	

	
