extends CharacterBody2D

const SPEED : float = 300.0
var is_moving : bool = false
var tween : Tween

func _process(_delta: float) -> void:
	pass
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

func _input(_event: InputEvent) -> void:
	_movement()
	is_moving = false
	
func _movement() -> void:
	if is_moving == true:
		return print("I can't move!")
	if Input.is_action_just_pressed("up"):
		tween = create_tween()
		tween.tween_property(self, "position", position + Vector2.UP * 128, 0.35) # It's alive!!
		is_moving = true

	if Input.is_action_just_pressed("down"):
		is_moving = true
		position += Vector2.DOWN * 50
	if Input.is_action_just_pressed("left"):
		is_moving = true
		position += Vector2.LEFT * 50
	if Input.is_action_just_pressed("right"):
		is_moving = true
		position += Vector2.RIGHT * 50
	
