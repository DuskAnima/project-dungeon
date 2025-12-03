@abstract
extends Node2D
class_name Entity

signal etbus
var movement_started : StringName = "movement_started"
var movement_finishied : StringName = "movement_finished"

var tween : Tween
var can_move : bool = true
@export var walk_speed : float = 0.2

func _ready() -> void:
	# Conecta al bus que comunica a la entity.gd con terrain.gd
	etbus.connect(EntityTerrainBus.connect_signal_to_bus)

func _process(_delta: float) -> void:
	movement_manager() 

## Función que maneja toda la lógica de movimiento.
## El movimiento debe ser instanciado en _process porque de ser manejado _input generaría un
## leve delay en los multi inputs (movimiento continuo del personjae en el grid)

func movement_manager() -> void:
	if can_move != true: # Por defecto el personaje puede caminar
		return
	var direction : Vector2i = _get_direction() # Se obtiene la dirección deseada
	if direction == Vector2i.ZERO: # La función avanza si existe input de dirección
		return
	# GridManager procesa la posición actual y la dirección deseada para calcular la nueva posición
	var new_position : Vector2 = GridManager.get_new_tile_position(position, direction) 
	if new_position == position: # La función avanza si la nueva posición es diferente a la posición actual
		return
	can_move = false # Evita que se superpongan animaciones de movimiento
	etbus.emit(movement_started) # Avisa al terreno el inicio del movimiento.
	_set_new_tile_position_tween(new_position) # la nueva posición será llevada a cabo por el tween.
	await tween.finished # Cuando el tween haya terminado enviará una señal para continuar.
	etbus.emit(movement_finishied) # Avisa a terrain.gd cuando su movimiento haya sido consolidado
	can_move = true # Ahora se puede, nuevamente, mover al personaje

## Función abstracta que retorna un Vector2i que determina la dirección del input de movimiento deseado.
## Requiere una implementación que especifique el método por el cual la entidad se moverá.
@abstract
func _get_direction() -> Vector2i

## Función que controla el tween del desplazamiento.
func _set_new_tile_position_tween(new_position : Vector2) -> void:
	tween = create_tween()
	tween.tween_property(self, "position", new_position, walk_speed) # It's alive!!
