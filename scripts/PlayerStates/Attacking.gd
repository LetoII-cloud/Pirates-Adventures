class_name Attacking extends PlayerState

var is_attacking = false
@onready var swing_sfx = $SwingSFX

func enter() -> void:
	is_attacking = true
	player.set_attack_zone()
	player.animationPlayer.play("attacktest")
	swing_sfx.play()
	return


func exit() -> void:
	is_attacking = false

func handle_input () -> void:
		
	return
	
func handle_physics (delta : float) -> void:
	

	return

func handle_update () -> void:
	
	return
	
func _on_basic_attack_area_area_entered(area: Area2D) -> void:
	if not area.is_in_group("hurtboxes"):
		return
	
	if area.zone != player.attack_zone:
		return	
		
	if area.has_method ("is_protected") and area.is_protected():
		area.handle_block_hit()
		return
			
	var dmg = player.sword.dmg
	area.take_damage(dmg)
		 


func _on_player_sprite_animation_finished() -> void:
	finish_attack()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attacktest":
		finish_attack()


func finish_attack() -> void:
	if is_attacking:
		finished.emit(IDLE)
