extends EnemyState

const MIN_GOAWAY_TIME := 0.35

var direction := -1
var goaway_time := 0.0

func enter() -> void:
	super()
	goaway_time = 0.0

	if enemy.is_blocking_hit:
		enemy.animatedSprite.play("blocking hit walking")
		enemy.is_blocking_hit = false
	elif enemy.is_blocking:
		enemy.animatedSprite.play("blocking walking")
	else:
		enemy.animatedSprite.play("walking", -1.0, true)
		
	if enemy.velocity.x < 0:
		direction = 1
	else:
		direction = -1
		
	return
	
func handle_physics (delta: float) -> void:
	goaway_time += delta
	
	if (enemy.is_on_wall() || enemy.is_on_edge()):
		direction *= -1
	
	handle_movement_with_direction_flag(direction, enemy.SPEED, false)

	if goaway_time < MIN_GOAWAY_TIME:
		return

	var isCollidingWithPlayer = is_raycast_colliding_with_player(enemy.raycastTacticsLeft, enemy.raycastTacticsRight, direction*-1)
	if not isCollidingWithPlayer:
		finished.emit(CHASING)
		
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	if enemy.is_blocking_hit:
		enemy.is_blocking_hit = false
		enemy.animatedSprite.play("blocking hit walking")
		
	var rng := RandomNumberGenerator.new()
	var chance_for_blocking := rng.randf_range(0, 1)
	if chance_for_blocking < 0.7:
		print('blocking by away')
		toggle_blocking.emit(true, "middle")
	return
	
signal toggle_blocking (block_active : bool, zone: String)
