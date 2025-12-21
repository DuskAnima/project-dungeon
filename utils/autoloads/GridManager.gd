extends Node

# ToDO:
# Capas lógicas separadas terrain/objects/entities/aux

## Atributo de elementos del terreno. 
var surface : Terrain
var wall : Terrain
var last_position : Vector2i
var next_position : Vector2i
var entity_direction : Vector2i

## Función utilizada para entregar un Terrain habitable para manipularlo como grid
func set_surface(tilemap: Terrain) -> void:
	surface = tilemap

## Funión utilizada para entregar un Terrain de pared para manipularlo como grid
func set_wall(tilemap: Terrain) -> void:
	wall = tilemap

func spawn_check(spawn_position : Vector2) -> void:
	print(spawn_position)

## Recibe la posición de la entidad (Vector2) y el input de movimiento deseado (Vector2i).
## Luego, retorna la posición en grid donde deberá situarse la entidad en función al input dado (Vector2).
## Cae en la responsabilidad de la entidad utilizar estas coordenadas para re ubicar su posición.
## Esta función solo crea el cálculo correspondiente.
func get_new_tile_position(e_position : Vector2, e_direction : Vector2i) -> Vector2:
	# Se almacena dirección de la entidad para usos posteriores
	entity_direction = e_direction
	# Se almacena la posición de la entidad basada en la localización del TileMap
	last_position = surface.local_to_map(e_position)
	# Luego calcula la nueva posición sumando la posición actual de la entidad con la dirección recibida
	next_position = last_position + e_direction
	if not _can_move_to(next_position):
		return surface.map_to_local(last_position)
	# Entonces se retorna el TileMap convertido a local position
	return surface.map_to_local(next_position)

## Retorna un Array[Vector2i] con la última[0] y la actual[1] posición ocupada por la entidad. 
func get_entity_position() -> Array[Vector2i]:
	return [last_position, next_position]

func get_front_tile() -> Vector2:
	return surface.map_to_local(next_position + entity_direction)

## Todo camino no transitable debe retornar false, en caso contrario será trasitable.
func _can_move_to(new_position : Vector2i) -> bool: # Recibe la posición del tile al cual se desea acceder
	if _surface_check(new_position) == false: return false
	if _wall_check(new_position) == false: return false
	else: return true

## Check que revisa si es posible el movimiento en Floor layer 
func _surface_check(new_position : Vector2i) -> bool:
	var surface_data : TileData = surface.get_cell_tile_data(new_position) # Obtiene la información del tile
	if surface_data == null: return false
	if surface_data.get_custom_data("is_solid") == true: return false
	else: return true

## Check que revisa si es posible el movimiento en Wall layer 
func _wall_check(new_position : Vector2i) -> bool:
	var wall_data : TileData = wall.get_cell_tile_data(new_position)
	if wall_data == null: return true
	if wall_data.get_custom_data("is_solid") == true: return false
	return true
