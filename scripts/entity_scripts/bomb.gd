extends Item

@export var can_break : bool = true
@export var can_explode : bool = true

func _ready() -> void:
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)


func detonation() -> void:
	sprite.play("detonation") # Conectar a señal de finalización de movimiento
	if sprite.animation_finished:
		print("olaaa")
		
func _on_movement_started() -> void:
	detonation()
