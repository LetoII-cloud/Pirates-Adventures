class_name Attacking extends PlayerState

var is_attacking = false
@onready var swing_sfx = $SwingSFX

func enter() -> void:
	is_attacking = true
	player.animationPlayer.play("attacktest")
	swing_sfx.play()
	return

func handle_input () -> void:
		
	return
	
func handle_physics (delta : float) -> void:
	

	return

func handle_update () -> void:
	
	return
	
func _on_basic_attack_area_area_entered(area: Area2D) -> void:
	var dmg = player.sword.dmg
	if area.is_in_group("hurtboxes"):
		area.take_damage(dmg)
		 


func _on_player_sprite_animation_finished() -> void:
	finished.emit(IDLE)
