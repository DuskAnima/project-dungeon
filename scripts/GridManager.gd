extends Node

# ToDO:
# Capas lógicas separadas terrain/objects/entities/aux

## Atributo de elementos del terreno. 
var terrain : TileMapLayer
var current_entity_position : Vector2i
var last_position : Vector2i
var next_position : Vector2i

## Recibe self del terreno para manipularlo como grid
func set_terrain(tilemap: TileMapLayer) -> void:
	terrain = tilemap

## Recibe la posición de la entidad (Vector2) y el input de movimiento deseado (Vector2i).
## Luego, retorna la posición en grid donde deberá situarse la entidad en función al input dado.
## Cae en la responsabilidad de la entidad utilizar estas coordenadas para re ubicar su posición.
## Esta función solo crea el cálculo correspondiente.
func get_new_tile_position(e_position : Vector2, e_direction : Vector2i) -> Vector2: # Se recibe un valor de dirección
	# Se almacena la posición de la entidad basada en la localización del TileMap
	last_position = terrain.local_to_map(e_position)
	# Luego calcula la nueva posición sumando la posición actual de la entidad con la dirección recibida
	next_position = last_position + e_direction
	if not _can_move_to(next_position):
		return terrain.map_to_local(last_position)
	# Entonces se retorna el TileMap convertido a local position
	return terrain.map_to_local(next_position)

## Retorna un Array[Vector2i] con la última[0] y la actual[1] posición ocupada por la entidad. 
func get_entity_position() -> Array[Vector2i]:
	return [last_position, next_position]

## Todo camino no transitable debe retornar false, en caso contrario será trasitable.
func _can_move_to(new_position : Vector2i) -> bool: # Recibe la posición del tile al cual se desea acceder
	var terrain_data : TileData = terrain.get_cell_tile_data(new_position) # Obtiene la información del tile
	if terrain_data == null: return false
	if terrain_data.get_custom_data("is_solid") == true: return false
	else: return true
