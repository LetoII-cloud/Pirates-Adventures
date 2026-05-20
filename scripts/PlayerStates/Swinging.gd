class_name Swinging extends PlayerState

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.animatedSprite.play("falling")

func handle_input() -> void:
	if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("move_up") and player.current_rope:
		player.current_rope.release_player(true)
		finished.emit(JUMPING)

func handle_physics(delta: float) -> void:
	if not player.current_rope:
		finished.emit(FALLING)
		return

	player.global_position = player.current_rope.get_grab_position()
	player.velocity = Vector2.ZERO

func exit() -> void:
	pass
