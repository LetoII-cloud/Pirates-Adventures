extends Area2D

signal damage_info (dmg: int)
signal block_hit ()

@export_enum("top", "middle", "down") var zone: String = "middle"

func take_damage (dmg : int, attacked_area : String) -> void:
	if is_protected(attacked_area):
		handle_block_hit()
		return

	damage_info.emit(dmg)


func is_protected(attacked_area : String) -> bool:
	var player := get_parent() as Player
	return player != null and player.protected_zone == attacked_area


func handle_block_hit() -> void:
	block_hit.emit()
	
