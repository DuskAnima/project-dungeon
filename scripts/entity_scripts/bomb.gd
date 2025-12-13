extends Item

enum {DETONATION, EXPLOTION}

@export var can_break : bool = true
@export var can_explode : bool = true
var status : int 

func _ready() -> void:
	z_index = 3
	EntityTerrainBus.connect_bus_to_signal(_on_movement_started)

func detonation() -> void:
	status = DETONATION
	sprite.play("detonation")
	status = EXPLOTION

func explotion() -> void:

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
