extends Node
# Capas lógicas separadas terrain/objects/entities/aux

## Atributo de elementos del terreno. 
var terrain : TileMapLayer
## Atributo de entidad
var entity : Entity
## Atributo de animación Tween
var tween : Tween

## Recibe self del terreno para manipularlo como grid
func get_terrain(tilemap: TileMapLayer) -> void:
	terrain = tilemap

# Para probar la fución se está limitando al player, pero la idea es que reciba las entidades en general
## Recibe el self de la entidad que se quiere establecer en el grid
func add_entity(new_entity: CharacterBody2D) -> void:
	entity = new_entity

## Funcióm hecha para entregar el siguiente movimiento de la entidad. El movimiento está pensado para
## simular un sistema de grid. Lo que realmente ocurre es que se obtiene el TileLayer que corresponde al
## terreno y se utiliza el mapeo correspondiente para calcular la posición de la entidad. parseando el
## Vector2i a Vector2 y asignando la posición correspondiente. Al trabajar en base a equivalencias
## con terrain.local_to_layer() y terrain.map_to_local() se ha logrado crear un comportamiento 
## consistente. 
## **Modo de uso**: En func _input, llamar la función usando el singleton GridManager.
func move_entity(e_direction : Vector2i) -> void: # Cuando se recibe un valor de dirección
	if e_direction == Vector2i.ZERO: # Si el valor es cero, fin
		return 
	# Se almacena la posición de la entidad basada en la localización del TileMap
	var map_position : Vector2i = terrain.local_to_map(entity.get_position())
	# Luego calcula la nueva posición sumando la posición actual de la entidad con la dirección recibida
	var new_position : Vector2i = map_position + e_direction
	if _can_move(new_position) != true:
		return
	# Entonces se transforma el calculo de TileMap a local position
	var new_local_position : Vector2 = terrain.map_to_local(new_position)
	# Finalmente se actualiza la posición de la entidad, calzando tanto con el tile como la posición local
	_movement_animation(new_local_position)
	# ToDo:
		# Debo calcular la siguiente posición como Map
		# Luego ese Map lo transformo a local
		# Luego local se lo asigno al personaje
		# Itero

## Función anonima que determina si el jugador puede acceder a un determinado terreno. Retorna un booleano.
## Verdadero si es transitable, falso si no lo es
func _can_move(new_position : Vector2i) -> bool: # Recibe la posición del tile al cual se desea acceder
	var terrain_data : TileData = terrain.get_cell_tile_data(new_position) # Obtiene la información del tile
	if terrain_data == null:
		return false
	if terrain_data.get_custom_data("is_solid") == true: # Si el terreno es sólido
		return false # No es un camino transitable
	else:
		return true

func _movement_animation(new_local_position : Vector2) -> void:
	tween = create_tween()
	tween.tween_property(entity, "position", new_local_position, 0.20) # It's alive!!
