extends EnemyState

var chasingSpeed := 0.0
var direction = -1

func enter() -> void:
	chasingSpeed = enemy.SPEED * 2.5
	enemy.animatedSprite.play("running")
	return

func handle_physics (delta: float) -> void:
	if (enemy.is_on_wall()):
		direction *= -1
		
	handle_movement(direction, chasingSpeed)
	
	if is_raycast_colliding_with_player(enemy.raycastLeft, enemy.raycastRight, direction):
		finished.emit(ATTACKING)
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return
