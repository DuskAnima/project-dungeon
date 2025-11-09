extends CharacterBody2D
class_name Entity

# ToDO:
# Agregar limitación de movement manager para que no sea llamado 60 fps
# Incluir buffer en el movimiento del personaje para evitar que los cambios de input se sientan clanky

var tween : Tween
var can_move : bool = true

func _process(_delta: float) -> void:
	movement_manager()

#func _input(_event: InputEvent) -> void:
#	movement_manager()

## Función que maneja toda la lógica de movimientocomo hacer un git pull que sobreescriba cambios locales?
func movement_manager() -> void:
	var direction : Vector2i = _get_direction() # Se obtiene la dirección deseada
	if direction != Vector2i.ZERO and can_move == true:
		can_move = false
		# GridManager procesa la posición actual y la dirección deseada para calcular la nueva posición
		var new_position : Vector2 = GridManager.grid_movement(position, direction) 
		_movement_animation(new_position) # la nueva posición será llevada a cabo por el tween.
		await tween.finished # Cuando el tween haya terminado manddirectionará una señal para continuar con la ejecusión
		can_move = true


## Función privada que retorna un Vector2i que determina la dirección del input de movimiento deseado.
func _get_direction() -> Vector2i: 
	if Input.is_action_pressed("down"): return Vector2i.DOWN
	if Input.is_action_pressed("up"): return Vector2i.UP
	if Input.is_action_pressed("left"): return Vector2i.LEFT
	if Input.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO


## Función que controla el tween del desplazamiento.
func _movement_animation(new_position : Vector2) -> void:
	tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.20) # It's alive!!

"""
func jump() -> Vector2i:
	if Input.is_action_just_pressed("ui_accept"):
		return Vector2i.UP * 2
	else: 
		return Vector2i.ZERO
"""


"""	if direction != Vector2i.ZERO and Input.is_action_just_pressed("ui_accept"):
		_movement_animation(GridManager.grid_movement(position, jump()))"""
