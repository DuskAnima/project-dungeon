@abstract
extends Entity
class_name Item

func _get_direction() -> Vector2i:
	return Vector2i.ZERO

func _on_ready_hook() -> void:
	_on_ready_implement()

## 
@abstract
func _on_ready_implement() -> void
	
