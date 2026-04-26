class_name Equipment extends Node
	
var standardSword
var rums 	:= 0
var bombs 	:= 0
var coins	:= 0

@onready var playerStats = $"../PlayerStatistics"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	standardSword = StandardSword.new()
	return

func addRum () -> void:
	print ("Adding 1 Rum to the Equipment.")
	rums += 1
	print ("Rums: ", rums)
	return
	
func useRum () -> void:
	if (rums < 1):
		return
	else: 
		rums -= 1
	print ("Consuming 1 Rum.")
	print ("Rums:", rums)
	playerStats.usedRum();

class StandardSword extends Sprite2D :
	
	var dmg := 300
