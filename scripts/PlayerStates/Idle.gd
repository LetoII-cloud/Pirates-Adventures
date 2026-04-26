class_name Idle extends PlayerState

func enter() -> void:
	if not player:
		return
		
	player.velocity.x = 0
	player.animatedSprite.play("idle")
	return

func handle_input () -> void:
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	
	if (Input.is_action_just_pressed("attack_left")):
		finished.emit(ATTACKING)
	return
	
func handle_physics (delta : float) -> void:
	
	player.move_and_slide()
	
	if Input.get_axis("move_left", "move_right") or Input.get_axis("move_left", "move_right"):
		finished.emit(RUNNING)
	
	if not player.is_on_floor():
		finished.emit(FALLING)		
	

func handle_update () -> void:

	return
