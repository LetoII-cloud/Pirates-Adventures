extends EnemyState

var direction := -1

func enter() -> void:
	print('entering attack')
	enemy.animationPlayer.play("attack_newtest")
	enemy.animationPlayer.seek(0.0, true)
	enemy.times_attacked += 1
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	return

func handle_update () -> void:
	
	return


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "attacking":
		return
	if enemy.times_attacked < 2:
		finished.emit(GOAWAY)
	else:
		print('emitting')
		toggle_blocking.emit(true, "middle")

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtboxes"):
		print ("1")
		area.take_damage(enemy.enemyStatistics.attack_strength)
		
signal toggle_blocking (block_active : bool, zone: String)
