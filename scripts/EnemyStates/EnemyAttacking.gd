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
	#if anim_name != "attacking":
	#	return
	finished.emit(GOAWAY)
