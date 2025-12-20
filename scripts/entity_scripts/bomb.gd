extends Item

enum {DETONATION, EXPLOSION}

## Experimental: propiedad de objeto que determina si puede romper objetos
@export var can_break : bool = true
## Experimental: propiedad de objeto que determina si puede explotar objetos
@export var can_explode : bool = true

var status : int 

func _on_ready_implement() -> void:
	pass
	
func detonation() -> void:
	status = DETONATION
	sprite.play("detonation")
	status = EXPLOSION

func explosion() -> void:
	z_index = 3 # Establece su z-index en 3, por sobre las demás entidades, para que la explosión cubra visualmente a todo 
	sprite.play("explosion")
	await sprite.animation_finished
	queue_free()

func _on_movement_started() -> void:
	_bomb_controller()
	
func _bomb_controller() -> void:
	match status:
		EXPLOSION:
			explosion()
		DETONATION:
			detonation()
