class_name EnemyIdle extends EnemyState

func enter() -> void:
	if not enemy:
		return
		
	enemy.velocity.x = 0
	enemy.animatedSprite.play("idle")
	return

func handle_input () -> void:

	return
	
func handle_physics (delta : float) -> void:
	
	enemy.move_and_slide()
	
	if not enemy.is_on_floor():
		finished.emit(FALLING)		
	

func handle_update () -> void:

	return
