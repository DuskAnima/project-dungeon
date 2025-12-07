extends Entity

@onready var bomb_animation : AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomb_animation.play("idle")
	
func bomb() -> void:
	bomb_animation.play("detonation")

func _get_direction() -> Vector2i:
	return Vector2i.ZERO
