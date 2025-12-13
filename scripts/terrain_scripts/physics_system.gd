extends Node

func tile_break_system(can_break : bool) -> void:
	# Verificación Booleana de si un tile se puede romper
	var can_break : bool = terrain_tile_data.get_custom_data_by_layer_id(Data.CAN_BREAK) 
	if can_break: # Si es True
		var tile_breaker : Vector2i = tile_atlas_coords + Vector2i(1,0) # Se suma uno al siguiente estado del tile
		set_cell(current_entity_position, tile_id, tile_breaker) # Se establece el nuevo estado factual del tile en el mapa
