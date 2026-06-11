class_name Hurt extends PlayerState



func enter () -> void:
	player.animatedSprite.play("hit")
	
	

func handle_physics (delta: float) -> void:
	
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return


func _on_player_sprite_animation_finished() -> void:
	if player.animatedSprite.animation == "hit":
		finished.emit(IDLE)
