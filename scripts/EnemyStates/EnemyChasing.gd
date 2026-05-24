extends EnemyState

var chasingSpeed := 0.0
var direction = -1

func enter() -> void:
	super()
	chasingSpeed = enemy.SPEED * 2.5
	enemy.animatedSprite.play("running")
	return

func handle_physics (delta: float) -> void:
	var is_behind_player := is_back_raycast_colliding_with_player (enemy.raycastTacticsLeft, enemy.raycastTacticsRight, direction)
	if enemy.is_on_wall() or is_behind_player or enemy.is_on_edge():
		direction *= -1
		
	handle_movement(direction, chasingSpeed)
	
	if enemy.can_attack() and is_raycast_colliding_with_player(enemy.raycastLeft, enemy.raycastRight, direction):
		finished.emit(ATTACKING)
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return
