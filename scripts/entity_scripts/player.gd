extends Entity

#func _ready() -> void:
var Bomb : PackedScene = preload("uid://bix028rolwgaw")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("item"):
		set_bomb()

func _get_direction() -> Vector2i:
	if Input.is_action_pressed("down"): return Vector2i.DOWN
	if Input.is_action_pressed("up"): return Vector2i.UP
	if Input.is_action_pressed("left"): return Vector2i.LEFT
	if Input.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO

func set_bomb() -> void:
	var instance : Node2D= Bomb.instantiate()
	add_child(instance)
