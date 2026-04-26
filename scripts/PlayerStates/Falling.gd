class_name Falling extends PlayerState

func enter() -> void:
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:

	# handle movement during fall
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		player.set_facing(direction)
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

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
