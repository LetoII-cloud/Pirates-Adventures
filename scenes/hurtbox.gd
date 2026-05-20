extends Area2D

signal damage_info (dmg: int, zone: String)
signal block_hit ()

@export_enum("top", "middle", "down") var zone: String = "middle"

func take_damage (dmg : int) -> void:
	damage_info.emit(dmg, zone)
	
func is_protected() -> bool:
	var enemy := owner as Enemy
	return enemy.protected_zone == zone

func handle_block_hit () -> void:
	block_hit.emit()
	return
