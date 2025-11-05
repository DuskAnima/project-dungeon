extends Node
# ToDO:
# Capas lógicas separadas terrain/objects/entities/aux

## Atributo de elementos del terreno. 
var terrain : TileMapLayer

## Recibe self del terreno para manipularlo como grid
func get_terrain(tilemap: TileMapLayer) -> void:
	terrain = tilemap

## Toma la posición de la entidad (Vector2) y el input de movimiento deseado (Vector2i).
## Luego, retorna la posición en grid donde deberá situarse la entidad en función a tal input.
## Cae en la responsabilidad de la entidad utilizar estas coordenadas para re ubicar su posición.
func grid_movement(e_position : Vector2, e_direction : Vector2i) -> Vector2: # Se recibe un valor de dirección
	# Se almacena la posición de la entidad basada en la localización del TileMap
	var map_position : Vector2i = terrain.local_to_map(e_position)
	# Luego calcula la nueva posición sumando la posición actual de la entidad con la dirección recibida
	var new_position : Vector2i = map_position + e_direction
	if _can_move(new_position) != true:
		return e_position
	# Entonces se retorna el TileMap convertido a local position
	return terrain.map_to_local(new_position)

## Todo camino no transitable debe retornar false, en caso contrario será trasitable.
func _can_move(new_position : Vector2i) -> bool: # Recibe la posición del tile al cual se desea acceder
	var terrain_data : TileData = terrain.get_cell_tile_data(new_position) # Obtiene la información del tile
	if terrain_data == null: return false
	if terrain_data.get_custom_data("is_solid") == true: return false
	else: return true
