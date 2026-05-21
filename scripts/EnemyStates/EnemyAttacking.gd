extends EnemyState

@export var delayed_chase_seconds := 1

var direction := -1
var delayed_chase_time_left := 0.0


func enter() -> void:
	#super()
	delayed_chase_time_left = 0.0

	if enemy.is_blocking:
		toggle_blocking.emit(false, '')
	
	enemy.animationPlayer.play("attack_newtest")
		
	enemy.animationPlayer.seek(0.0, true)
	enemy.times_attacked += 1
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	return

func handle_update () -> void:
	if delayed_chase_time_left > 0.0:
		delayed_chase_time_left -= get_process_delta_time()

		if enemy.is_blocking_hit:
			enemy.is_blocking_hit = false
			enemy.animatedSprite.play("middle_block_hit")

		if delayed_chase_time_left <= 0.0:
			print("DELAYED CHASING")
			finished.emit(CHASING)

	return


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "attack_newtest":
		return
	
	var rng := RandomNumberGenerator.new()
	var chance_for_chasing := rng.randf_range(0, 1)
	if chance_for_chasing < 0.3:
		print("CHASING")
		finished.emit(CHASING)
	elif chance_for_chasing >= 0.3 and chance_for_chasing < 0.6:
		print("BLOCKING THEN CHASING")
		enemy.disable_attack_collision()
		enemy.velocity.x = 0.0
		toggle_blocking.emit(true, "middle")
		enemy.animatedSprite.play("blocking")
		delayed_chase_time_left = delayed_chase_seconds
	else:
		toggle_blocking.emit(true, "middle")
		finished.emit(GOAWAY)
		

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtboxes"):
		area.take_damage(enemy.enemyStatistics.attack_strength)
		
signal toggle_blocking (block_active : bool, zone: String)
