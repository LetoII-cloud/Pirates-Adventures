extends EnemyState

var direction := -1

var already_spotted_player := false

func enter() -> void:
	super()
	
	if enemy.is_blocking:
		enemy.animatedSprite.play("block_goaway")
	else:
		enemy.animatedSprite.play("walking")
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	if (enemy.is_on_wall() || enemy.is_on_edge()):
		direction *= -1
		
	handle_movement(direction, enemy.SPEED)

	if is_raycast_colliding_with_player(enemy.raycastLeft, enemy.raycastRight, direction):
		finished.emit(ATTACKING)
	
	if not enemy.is_on_floor():
		finished.emit(FALLING)
		
	if is_raycast_colliding_with_player(enemy.sightRayCastLeft, enemy.sightRayCastRight, direction):
		handle_spotted_player()

	return
	
func handle_spotted_player () -> void:
	if !already_spotted_player:
		already_spotted_player = true
		dialogue_requested.emit()
		finished.emit(CHASING)
	return
	
signal dialogue_requested ()

func handle_update () -> void:
	
	return
