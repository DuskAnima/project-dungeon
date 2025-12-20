@abstract
extends  Entity
class_name Character

var Bomb : PackedScene = preload("uid://bix028rolwgaw")

func set_bomb() -> void:
	var instance : Node2D = Bomb.instantiate()
	instance.position = GridManager.get_front_tile()
	item_layer.add_child(instance)

	
