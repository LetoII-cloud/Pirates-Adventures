class_name Equipment extends Node
	
var standardSword

@export var rums 	:= 0
@export var bombs 	:= 0
@export var coins	:= 0
@export var initial_ammo := 5
@export var ammo : int:
	set(value):      
		ammo = value
		ammo_amount_change.emit(value)

@onready var playerStats = $"../PlayerStatistics"
@onready var standard_gun = $StandardGun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	standardSword = StandardSword.new()
	return
	
func _physics_process(delta: float) -> void:
	# should I define it here or on player.gd level?
	if Input.is_action_just_pressed("use_rum"):
		useRum()
		
	

func addRum () -> void:
	print ("Adding 1 Rum to the Equipment.")
	rums += 1
	print ("Rums: ", rums)
	return
	
func useRum () -> void:
	if (rums < 1):
		return
	elif playerStats.usedRum():
		rums -= 1
		print ("Consuming 1 Rum.")
		print ("Rums:", rums)

	

signal ammo_amount_change (new_amount : int)

class StandardSword extends Sprite2D :
	
	var dmg := 30
