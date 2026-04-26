class_name Jump extends PlayerState

func enter() -> void:
	# handle jump
	player.velocity.y = player.JUMP_VELOCITY
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	player.move_and_slide()
		
	# handle movement during jump
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		player.set_facing(direction)
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		
	if player.velocity.y > 0:
		finished.emit(FALLING)
	
	return

func handle_update () -> void:
	player.animatedSprite.play("jumping")
	return
