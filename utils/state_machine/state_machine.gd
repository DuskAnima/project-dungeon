extends Node
class_name StateMachine

## Nodo que vamos a controlar
@onready var controlled_node : Node = self.owner
## Estado por defecto
@export var default_state : StateBase
## Estado en ejecución
var current_state : StateBase = null

func _ready() -> void:
	call_deferred("_state_default_start")
	
func _state_default_start() -> void:
	current_state = default_state
	_state_start()

## Función que prepara las variables para el nuevo estado y lanza su start
func _state_start() -> void:
	prints("StateMachine", controlled_node.name, "start state", current_state.name)
	## Configuramos el estado
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()
	
## Método para cambiar de estados
func change_to(new_state : String) -> void:
	if current_state and current_state.has_method("end"): current_state.end()
	current_state = get_node(new_state)
	_state_start()
	
# Hooks de métodos 

func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)
	
func _input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)
	
func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)

func _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)
