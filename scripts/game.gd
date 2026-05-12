extends Node2D

@onready var health_label = $InfoUI/HealthLabel
@onready var ammo_label = $InfoUI/AmmoLabel
@onready var player = $Player

var health_label_template : String = "Health: <health>"
var ammo_label_template : String = "Ammo: <ammo>"

func _ready() -> void:
	prepare_projectile_spawner()
	update_health_label(100)
	update_ammo_label(0)
	

func update_health_label (new_health : int) -> void:
	var text 	: String 	= health_label.text
	var newText : String 	= health_label_template.replace("<health>", str(new_health))
	health_label.text = newText
	
func update_ammo_label (new_ammo : int) -> void:
	var text 	: String 	= ammo_label.text
	var newText : String 	= ammo_label_template.replace("<ammo>", str(new_ammo))
	ammo_label.text = newText


func _on_player_notify_ui(which_label : String, new_amount: int) -> void:
	if (which_label == "health"):
		update_health_label(new_amount)
	elif (which_label == "ammo"):
		update_ammo_label(new_amount)
		
func prepare_projectile_spawner ():
	player.equipment.standard_gun.spawn_projectile.connect($ProjectileSpawner.spawn)
