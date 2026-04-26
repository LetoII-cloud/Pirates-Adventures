extends EnemyState

var direction := -1

func enter() -> void:
	enemy.animatedSprite.play("walking")
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	if (enemy.is_on_wall()):
		direction *= -1
		
	handle_movement(direction, enemy.SPEED)

	if is_raycast_colliding_with_player(enemy.raycastLeft, enemy.raycastRight, direction):
		finished.emit(ATTACKING)
	
	if not enemy.is_on_floor():
		finished.emit(FALLING)

	return

func handle_update () -> void:
	
	return
