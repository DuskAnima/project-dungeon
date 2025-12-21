@abstract
extends Node 
class_name StateBase

## Referencia al Character.
@onready var controlled_node : Node = self.owner
## Referencia a la máquina de estados.
var state_machine : StateMachine

## Método que se ejecuta al entrar en el estado.
func start() -> void:
	pass

## Método que se ejecuta al salir del estado.
func end() -> void:
	pass
