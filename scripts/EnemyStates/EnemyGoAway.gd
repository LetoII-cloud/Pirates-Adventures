extends EnemyState

var direction = -1

func enter() -> void:
	enemy.animatedSprite.play("goaway")
	if enemy.velocity.x < 0:
		direction *= -1
		
	return
	
func handle_physics (delta: float) -> void:
	
	if (enemy.is_on_wall()):
		direction *= -1
	
	handle_movement_with_direction_flag(direction, enemy.SPEED, false)

	var isCollidingWithPlayer = is_raycast_colliding_with_player(enemy.raycastTacticsLeft, enemy.raycastTacticsRight, direction*-1)
	if not isCollidingWithPlayer:
		finished.emit(CHASING)
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return
