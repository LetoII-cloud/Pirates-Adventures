extends Area2D

signal damage_info (dmg: int)

func take_damage (dmg : int) -> void:
	print('dmg = ', dmg)
	damage_info.emit(dmg)
	
