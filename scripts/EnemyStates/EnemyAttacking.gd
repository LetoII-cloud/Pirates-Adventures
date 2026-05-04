extends EnemyState

var direction := -1

func enter() -> void:
	enemy.animationPlayer.play("attack_newtest")
	enemy.animationPlayer.seek(0.0, true)
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	return

func handle_update () -> void:
	
	return


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# TO-DO : sprawdzic o co tu chodzi, czemu zakomentowane i co z tym zrobic
	#if anim_name != "attacking":
	#	return
	finished.emit(GOAWAY)


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtboxes"):
		print ("1")
		area.take_damage(enemy.enemyStatistics.attack_strength)
