class_name Equipment extends Node

var rums 	:= 0
var bombs 	:= 0
var coins	:= 0

@onready var playerStats = $"../PlayerStatistics"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Equipment attached to the Player")
	return

func addRum () -> void:
	print ("Adding 1 Rum to the Equipment.")
	rums += 1
	print ("Rums: ", rums)
	return
	
func useRum () -> void:
	print ("Consuming 1 Rum.")
	rums -= 1
	print ("Rums:", rums)
	playerStats.usedRum();
