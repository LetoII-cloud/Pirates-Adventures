class_name Jump extends PlayerState

const AIR_BRAKE_MULTIPLIER := 8.0

func enter() -> void:
	# handle jump
	if player.keep_velocity_on_next_jump:
		player.keep_velocity_on_next_jump = false
	else:
		player.velocity.y = player.JUMP_VELOCITY
	return

func handle_input () -> void:
	if Input.is_action_just_pressed("jump") and player.try_grab_nearby_rope():
		return

	return
	
func handle_physics (delta : float) -> void:
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	player.move_and_slide()
		
	# handle movement during jump
	var direction := Input.get_axis("move_left", "move_right")
	var air_brake := player.SPEED * AIR_BRAKE_MULTIPLIER * delta
	if direction != 0:
		player.set_facing(direction)
		var target_speed := direction * player.SPEED
		if player.velocity.x * direction > player.SPEED:
			player.velocity.x = move_toward(player.velocity.x, target_speed, air_brake)
		else:
			player.velocity.x = target_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, air_brake)
		
	if player.velocity.y > 0:
		finished.emit(FALLING)
	
	return

func handle_update () -> void:
	player.animatedSprite.play("jumping")
	return
