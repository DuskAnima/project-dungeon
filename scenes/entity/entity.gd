@abstract
extends Node2D
class_name Entity

## Esta señal referencia al bus EntityTerrainBus.gd, sirve para conectar señales de Entity a Terrain.
signal etbus
## Variable que almacena el nombre de la señal que da aviso al inicio del movimiento de una entidad.
const movement_started : StringName = "movement_started"
## Variable que almacena el nombre de la señal que da aviso al final del movimiento de una entidad.
const movement_finished : StringName = "movement_finished"
## Variable que almacena el tween de los movimientos de todas las entidades.
var tween : Tween
## Variable que controla si una entidad puede o no moverse. Se settea en False en medio del tween de movimiento.
## Se settea en True cuando el tween no está activo.
var can_move : bool = true
var direction : Vector2i
## Propiedad que almacena el nodo AnimatedSprite2D de la respectiva entidad. Se debe referenciar al nodo desde el inspector.
@export var sprite : AnimatedSprite2D
## Propiedad que almacena la velocidad de movimiento global (tween) de todas las entidades.
@export var walk_speed : float = 0.3
## Referencia global al Nodo2D "ItemLayer". Se utiliza para instanciar entidades de tipo Item.
@onready var item_layer : Node2D = get_node("/root/Main/ItemLayer")

func _ready() -> void:
	GridManager.spawn_check(position)
	# Conecta al bus que comunica a la entity.gd con terrain.gd
	etbus.connect(EntityTerrainBus.connect_signal_to_bus)
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started) # Conecta con la señal/propiedad de entity "movement_started"
	_on_ready_hook()

## Función que se ejecuta posterior a los settings de _ready(). Se utiliza para extender el comportamiento de _ready()
## desde las subclases derivativas de entity.
@abstract
func _on_ready_hook() -> void

func _process(_delta: float) -> void:
	_movement_manager()  # Instancia _movement_manager() debajo de

## Función que maneja toda la lógica de movimiento.
## El movimiento debe ser instanciado en _process porque de ser manejado _input generaría un
## leve delay en los multi inputs (movimiento continuo del personjae en el grid)
func _movement_manager() -> void:
	if can_move != true: # Por defecto el personaje puede caminar
		return
	direction = _get_direction() # Se obtiene la dirección deseada
	_face_direction()
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
	etbus.emit(movement_finished) # Avisa a terrain.gd cuando su movimiento haya sido consolidado
	can_move = true # Ahora se puede, nuevamente, mover al personaje


## Función abstracta que retorna un Vector2i que determina la dirección del input de movimiento deseado.
## Requiere una implementación que especifique el método por el cual la entidad se moverá.
@abstract
func _get_direction() -> Vector2i

@abstract
func _on_movement_started() -> void

## Función que controla el tween del desplazamiento.
func _set_new_tile_position_tween(new_position : Vector2) -> void:
	tween = create_tween()
	tween.tween_property(self, "position", new_position, walk_speed) # It's alive!!

func _face_direction() -> void:
	if direction == null || direction == Vector2i.ZERO:
		return
	if direction == Vector2i.UP:
		sprite.play("up")
	if direction == Vector2i.DOWN:
		sprite.play("down")
	if direction == Vector2i.LEFT:
		sprite.play("left")
	if direction == Vector2i.RIGHT:
		sprite.play("right")
	else:
		return
