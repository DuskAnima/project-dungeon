extends CharacterBody2D
class_name Entity

const SPEED : float = 300.0
var is_moving : bool = false
var tween : Tween

func _ready() -> void:
	GridManager.add_entity(self)
	print("Entity")
	move_and_slide()

func _process(_delta: float) -> void:
	pass
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

func _input(_event: InputEvent) -> void:
	var direction : Vector2i = _get_direction()
	GridManager.move_entity(direction)

## Get direccition envía la dirección del Input
func _get_direction() -> Vector2i: 
	if Input.is_action_just_pressed("down"):
		return Vector2i.DOWN
	if Input.is_action_just_pressed("up"):
		return Vector2i.UP
	if Input.is_action_just_pressed("left"):
		return Vector2i.LEFT
	if Input.is_action_just_pressed("right"):
		return Vector2i.RIGHT
	else:
		return Vector2i.ZERO

func _movement() -> void:
	if is_moving == true:
		return print("I can't move!")
	if Input.is_action_just_pressed("up"):
		tween = create_tween()
		tween.tween_property(self, "position", position + Vector2.UP * 128, 0.35) # It's alive!!
		is_moving = true
