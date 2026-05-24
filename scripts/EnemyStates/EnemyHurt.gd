extends EnemyState

signal hurt_finished ()

func enter () -> void:
	super()
	# the commented lines below are to review in the future.
	# Without them the hurt animation seems to be looped for a moment
	enemy.animationPlayer.pause()
	enemy.get_node("AnimatedSprite2D/AttackArea/AttackCollision").set_deferred("disabled", true)
	enemy.animatedSprite.play("hit")
	#enemy.times_hurt += 1
	#enemy.toggle_hurt_cooldown (true)
	

func handle_physics (delta: float) -> void:
		
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	if enemy.seconds_since_hurt < 1 and enemy.times_hurt > 1:
		enemy.stateMachine.lock_transitions = false
		print('emituje attacking!!!!!!!')
		finished.emit(ATTACKING)
	return


func _on_animated_sprite_2d_animation_finished() -> void:
	
	# przerobic na taktyczne
	if enemy.animatedSprite.animation == "hit":
		hurt_finished.emit()
		#toggle_blocking.emit(true, "middle")	
		finished.emit(CHASING)

signal toggle_blocking (block_active : bool, zone: String)
