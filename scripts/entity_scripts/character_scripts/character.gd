@abstract
extends  Entity
class_name Character

var Bomb : PackedScene = preload("uid://bix028rolwgaw")

func _input(_event: InputEvent) -> void:
	if can_move == false:
		return
	if Input.is_action_just_pressed("item"):
		set_bomb()

func set_bomb() -> void:
	var instance : Node2D = Bomb.instantiate()
	instance.position = position
	item_layer.add_child(instance)
