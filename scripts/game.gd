extends Node2D

@onready var health_label = $InfoUI/HealthLabel
@onready var ammo_label = $InfoUI/AmmoLabel
@onready var rum_label = $InfoUI/RumLabel
@onready var player = $Player
@onready var level_manager = $LevelManager

var health_label_template : String = "Health: <health>"
var ammo_label_template : String = "Ammo: <ammo>"
var rum_label_template : String = "Rum: <rum>"

func _ready() -> void:
	prepare_projectile_spawner()
	update_ui_from_player()

func update_ui_from_player() -> void:
	update_health_label(player.playerStatistics.health)
	update_ammo_label(player.equipment.ammo)
	update_rum_label(player.equipment.rums)
		
func update_health_label (new_health : int) -> void:
	var newText : String 	= health_label_template.replace("<health>", str(new_health))
	health_label.text = newText
	
func update_ammo_label (new_ammo : int) -> void:
	var newText : String 	= ammo_label_template.replace("<ammo>", str(new_ammo))
	ammo_label.text = newText
	
func update_rum_label (new_rum : int) -> void:
	var newText : String 	= rum_label_template.replace("<rum>", str(new_rum))
	rum_label.text = newText


func _on_player_notify_ui(which_label : String, new_amount: int) -> void:
	if (which_label == "health"):
		update_health_label(new_amount)
	elif (which_label == "ammo"):
		update_ammo_label(new_amount)
	elif (which_label == "rum"):
		update_rum_label(new_amount)
		
func prepare_projectile_spawner ():
	player.equipment.standard_gun.spawn_projectile.connect($ProjectileSpawner.spawn)
	
