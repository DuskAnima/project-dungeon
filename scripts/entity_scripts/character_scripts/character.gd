@abstract
extends  Entity
class_name Character

var Bomb : PackedScene = preload("uid://bix028rolwgaw")

func set_bomb() -> void:
	var instance : Node2D = Bomb.instantiate()
	instance.position = position + Vector2(16, 0)
	item_layer.add_child(instance)
