class_name CharacterStatistics extends Node

# TO-DO: move it to some configuration of collectibles. Possibly export?
@export var rumHealthIncreaseValue : int

@export var health : int:
	set(value):
		health = value
		health_changed.emit(health)

func take_damage (dmg : float) -> float:
	health = clamp(health-dmg, 0, 100)
	return health

func usedRum () -> bool:
	if health == 100:
		return false
	health = clamp(health + rumHealthIncreaseValue, 0, 100)
	print(health)
	print('----')
	return true
	

signal health_changed (new_health : int)
