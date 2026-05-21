class_name EnemyIdle extends EnemyState

func enter() -> void:
	super()
	
	if not enemy:
		return
		
	enemy.velocity.x = 0
	if enemy.is_blocking:
		enemy.animatedSprite.play("blocking")
	else:
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
