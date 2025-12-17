extends Item

enum {DETONATION, EXPLOTION}

## Experimental: propiedad de objeto que determina si puede romper objetos
@export var can_break : bool = true
## Experimental: propiedad de objeto que determina si puede explotar objetos
@export var can_explode : bool = true

var status : int 

func _on_ready_implement() -> void:
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started) # Conecta con la señal/propiedad de entity "movement_started"

func detonation() -> void:
	status = DETONATION
	sprite.play("detonation")
	status = EXPLOTION

func explotion() -> void:
	z_index = 3 # Establece su z-index en 3, por sobre las demás entidades, para que la explosión cubra visualmente a todo 
	sprite.play("explotion")
	await sprite.animation_finished
	queue_free()

func _on_movement_started() -> void:
	_bomb_controller()
	
func _bomb_controller() -> void:
	match status:
		EXPLOTION:
			explotion()
		DETONATION:
			detonation()
