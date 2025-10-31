extends Node
# Tile size: 32 pixels
# Origen 0,0
# Representación lógica del mapa: Diccionario
# Capas lógicas separadas terrain/objects/entities/aux
## Atributo de elementos del terreno. 
var terrain : TileMapLayer
## Atributo de entidad
var entity : Entity
## Atributo de animación Tween
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

## Recibe self del terreno para manipularlo como grid
func get_terrain(tilemap: TileMapLayer) -> void:
	terrain = tilemap

# Para probar la fución se está limitando al player, pero la idea es que reciba las entidades en general
## add_entity() -> Recibe el self de la entidad que se quiere establecer en el grid
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
	if e_direction != Vector2i.ZERO: # Si el valor no es cero:
	# Se almacena la posición de la entidad basada en la localización del TileMap
		var map_position : Vector2i = terrain.local_to_map(entity.get_position()) 
	# Luego calcula la nueva posición sumando la posición actual de la entidad con la dirección recibida
		var new_position : Vector2i = map_position + e_direction
	# Entonces se transforma el calculo de TileMap a local position
		var new_local_position : Vector2 = terrain.map_to_local(new_position)
	# Finalmente se actualiza la posición de la entidad, calzando tanto con el tile como la posición local
		entity.position = new_local_position
	# ToDo:
		# Debo calcular la siguiente posición como Map
		# Luego ese Map lo transformo a local
		# Luego local se lo asigno al personaje
		# Itero
