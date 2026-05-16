class_name Falling extends PlayerState

const AIR_BRAKE_MULTIPLIER := 8.0

func enter() -> void:
	return

func handle_input () -> void:
	if Input.is_action_just_pressed("jump") and player.try_grab_nearby_rope():
		return

	return
	
func handle_physics (delta : float) -> void:

	# handle movement during fall
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

	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		
	player.move_and_slide()
		
	if player.is_on_floor():
		finished.emit(IDLE)
		return
	
			
	return

func handle_update () -> void:
	player.animatedSprite.play("falling")
	return
