extends EnemyState

signal hurt_finished ()

func enter () -> void:
	# the commented lines below are to review in the future.
	# Without them the hurt animation seems to be looped for a moment
	enemy.animationPlayer.pause()
	enemy.get_node("AnimatedSprite2D/AttackArea/AttackCollision").set_deferred("disabled", true)
	enemy.animatedSprite.play("hit")
	
	

func handle_physics (delta: float) -> void:
	
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return


func _on_animated_sprite_2d_animation_finished() -> void:
	hurt_finished.emit()
	if enemy.animatedSprite.animation == "hit":
		finished.emit(CHASING)
