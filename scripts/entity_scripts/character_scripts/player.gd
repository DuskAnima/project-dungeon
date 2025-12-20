extends Character

func _on_ready_hook() -> void:
	z_index = 1 # Establece el z-index en 1 para quedar por sobre el piso y las paredes, pero por debajo de los umbrales de puertaa

func _get_direction() -> Vector2i:
	if Input.is_action_pressed("down"): return Vector2i.DOWN
	if Input.is_action_pressed("up"): return Vector2i.UP
	if Input.is_action_pressed("left"): return Vector2i.LEFT
	if Input.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO

func _input(_event: InputEvent) -> void:
	if can_move == false:
		return
	if Input.is_action_just_pressed("item"):
		set_bomb()

func _on_movement_started() -> void:
	pass
