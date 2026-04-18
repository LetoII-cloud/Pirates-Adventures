extends Node

var health := 60

# TO-DO: move it to some configuration of collectibles. Possibly export?
@export var rumHealthIncreaseValue := 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print ("Player statistics attached.")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func usedRum () -> void:
	health = clamp(health+rumHealthIncreaseValue, 0, 100)
	print("Health = ", health)
	return
