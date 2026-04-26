class_name EnemyFalling extends EnemyState

func enter() -> void:
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:

	if not enemy.is_on_floor():
		enemy.velocity += enemy.get_gravity() * delta
		
	enemy.move_and_slide()
		
	if enemy.is_on_floor():
		finished.emit(WALKING)
		return
	
			
	return

func handle_update () -> void:
	enemy.animatedSprite.play("idle") # change later
	return
