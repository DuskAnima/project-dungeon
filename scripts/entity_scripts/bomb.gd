extends Entity

@onready var bomb_animation : AnimatedSprite2D = $AnimatedSprite2D

func bomb() -> void:
	bomb_animation.play("detonation")

func _get_direction() -> Vector2i:
	return Vector2i.ZERO
