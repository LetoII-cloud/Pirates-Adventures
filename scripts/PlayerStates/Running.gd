class_name Running extends PlayerState

func enter() -> void:
	return

func handle_input () -> void:
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		
	return
	
func handle_physics (delta : float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		finished.emit(IDLE)
		
	player.set_facing(direction)
	player.move_and_slide()

	return

func handle_update () -> void:
	
	player.animatedSprite.play("running")
	return
