extends Entity

#func _ready() -> void:


func _get_direction() -> Vector2i:
	if Input.is_action_pressed("down"): return Vector2i.DOWN
	if Input.is_action_pressed("up"): return Vector2i.UP
	if Input.is_action_pressed("left"): return Vector2i.LEFT
	if Input.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO
