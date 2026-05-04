class_name CharacterStatistics extends Node

@export var health : int

func take_damage (dmg : float) -> float:
	health = health-dmg
	print (health)
	return health
