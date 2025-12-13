extends Item

@export var can_break : bool = true
@export var can_explode : bool = true

func _ready() -> void:
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)

func detonation() -> void:
	sprite.play("detonation")

func _on_movement_started() -> void:
	detonation()

func _on_detonation_animation_finished() -> void:
	queue_free()
